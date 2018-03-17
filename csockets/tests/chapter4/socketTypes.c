
#include <unistd.h>
#include <sys/socket.h>
#include <assert.h>

void RunTinyTests();

// when a socket is created, it is nameless (without
// an address). A valid socket address must be
// set up and the function bind() called to give
// the socket and address
//
// can not read from or write to this socket
// recall SOCK_STREAM requires a connection,
// see Socket By Example P125
void test_createPFLocalStreamSocket() {
    int s;
    ssize_t sz;
    char buf[16] = "there";
    s = socket(PF_LOCAL, SOCK_STREAM, 0);
    assert(-1 != s);

    // not connected - read/write are rejected
    sz = write(s, buf, sizeof(buf));
    assert(-1 == sz);
    sz = read(s, buf, 3);
    assert(-1 == sz);

    assert(0 == close(s));
}

void test_createPFLocalDGramSocket() {
    int s;
    s = socket(PF_LOCAL, SOCK_DGRAM, 0);
    assert(-1 != s);
    assert(0 == close(s));
}

// Automatically choose TCP Protocol.
// TCP part of the TCP/IP designation is the transport level
// protocol that is built on top of the IP layer.
// This provides the data packet sequencing, error control and
// recovery.
// In short TCP makes it possible to provide a stream socket
// using the Internet Protocol.
void test_createPFINetStreamSocket() {
    int s;
    s = socket(PF_INET, SOCK_STREAM, 0);
    assert(0 == close(s));
}

void test_createUDPSocket() {
    int s;
    s = socket(PF_INET, SOCK_DGRAM, 0);
    assert(-1 != s);
    assert(0 == close(s));
}

int main(int argc, char **argv) {
    RunTinyTests();
    return 0;
}
