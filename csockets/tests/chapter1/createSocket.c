
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>

// read also:
// http://beej.us/net2/html/syscalls.html
// refresher: what is AF and PF (hint - something family)

typedef struct {
    int r_sock;
    int w_sock;
    int domain;
    int type;
    int protocol;
} sock_t;

static sock_t* _sock = NULL;

void setUp() {
    _sock = malloc(sizeof(sock_t));
    int tmp[2];
    _sock->domain = AF_LOCAL;
    _sock->type = SOCK_STREAM;

    // protocol of 0 allows the OS to choose the correct default protocol to be
    // used for the domain (Socket by Example P63)
    _sock->protocol = 0;
    assert(0 == socketpair(_sock->domain, _sock->type, _sock->protocol, tmp));
    _sock->r_sock = tmp[0];
    _sock->w_sock = tmp[1];
}

void tearDown() {
    assert(0 == close(_sock->r_sock));
    assert(0 == close(_sock->w_sock));
    free(_sock);
    _sock = NULL;
}

void RunTinyTests();

// AF_LOCAL is unix domain (preferred over AF_UNIX)
// AF_LOCAL sockets are also referred to as Unix sockets
// netstat --unix -p
// expect to see the name of this executable to show in the program column
// see also linux socket by example P63
// for socketpair() function, the domain arg must always be
// AF_LOCAL or AF_UNIX
void test_createSocketExpectSuccess() {
    assert(_sock->r_sock);
}

// source: Linux S P BY E
// P37: pipe function creates a line of communications in one
// direction only
// sockets allow processes to communicate in both directions
void test_compareSocketsToPipes() {
    int s[2];
    int r_fd = -1;
    int w_fd = -1;
    typedef union {
        char buf[32];
        unsigned int num;
    } data_t;
    data_t d;
    d.num = 0xDEADBEEF;
    assert(0 == pipe(s));
    r_fd = s[0];
    w_fd = s[1];
    assert(sizeof(d.num) == write(w_fd, d.buf, sizeof(d.num)));
    d.num = 0x0;
    assert(sizeof(d.num) == read(r_fd, d.buf, sizeof(d.num)));
    assert(0xDEADBEEF == d.num);
    close(r_fd);
    close(w_fd);
}

void test_createSocketExpectFailure() {
    int z;
    int s[2];
    z = socketpair(-1, -1, 0, s);
    assert(-1 == z);
}

void test_performIOExpectSuccess() {
    ssize_t z;
    char buf[80];

    // no null byte is written, because only 5 bytes are specified in count arg
    z = write(_sock->w_sock, "dOOm!", 5);
    assert(5 == z);
    
    // any message up to the maximum size of array buf[] can be read
    z = read(_sock->r_sock, buf, sizeof(buf));
    assert(5 == z);
    buf[z] = '\0';
    z = strcmp("dOOm!", buf);
    assert(0 == z);

    // traffic in both directions
    write(_sock->r_sock, ">>DooM<<", 8);
    z = read(_sock->w_sock, buf, sizeof(buf));
    buf[z] = '\0';
    z = strcmp(">>DooM<<", buf);
    assert(0 == z);
}

// Linux Socket by Example
// P46
// The problem develops when the local process wants to signal to
// the remote endpoint that there is no more data to be received.
// If the local process closes its socket, this much will be
// accomplished. However if it needs to receive a confirmation
// from the remote end, it can not, because its socket is now
// closed.
void test_shutdownSocketExpectUnreadable() {
    char buf[80];
    memset(buf, 1, 80);
    assert(0 == shutdown(_sock->w_sock, SHUT_WR));
    read(_sock->r_sock, buf, 80);
    assert(1 == buf[0]);
}

void test_duplicateSocketAndRefCount() {
    int dw = dup(_sock->w_sock);
    unsigned int v = 0xDEADDEEF;
    unsigned int sut = 0;
    size_t sz = sizeof(unsigned int);
    write(dw, &v, sz);
    read(_sock->r_sock, &sut, sz);
    assert(v == sut);

    // P49
    // nothing happens yet
    close(dw);
    
    v = 101;
    write(_sock->w_sock, &v, sz);
    read(_sock->r_sock, &sut, sz);
    assert(101 == sut);

}

int main(int argc, char **argv) {
    RunTinyTests();
    return 0;
}

