
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>

// read also:
// http://beej.us/net2/html/syscalls.html
// refresher: what is AF and PF (hint - something family)

void RunTinyTests();

// AF_LOCAL is unix domain (preferred over AF_UNIX)
// netstat -p 
// expect to see the name of this executable to show in the program column
void test_createSocketExpectSuccess() {
    int z;
    int s[2];
    // protocol of 0 allows the OS to choose the correct default protocol to be
    // used for the domain (Socket by Example P63)
    z = socketpair(AF_LOCAL, SOCK_STREAM, 0, s);
    assert(0 == z);
}

void test_createSocketExpectFailure() {
    int z;
    int s[2];
    z = socketpair(-1, -1, 0, s);
    assert(-1 == z);
}

void test_performIOExpectSuccess() {
    ssize_t z;
    int s[2];
    char buf[80];
    z = socketpair(AF_LOCAL, SOCK_STREAM, 0, s);
    assert(0 == z);
    
    // no null byte is written, because only 5 bytes are specified in count arg
    z = write(s[1], "dOOm!", 5);
    assert(5 == z);
    
    // any message up to the maximum size of array buf[] can be read
    z = read(s[0], buf, sizeof(buf));
    assert(5 == z);
    buf[z] = '\0';
    z = strcmp("dOOm!", buf);
    assert(0 == z);

    // traffic in both directions
    write(s[0], ">>DooM<<", 8);
    z = read(s[1], buf, sizeof(buf));
    buf[z] = '\0';
    z = strcmp(">>DooM<<", buf);
    assert(0 == z);
    
    // close
    z = close(s[1]);
    assert(0 == z);

    z = close(s[0]);
    assert(0 == z);

    // see Five Pitfalls of Linux Socket Programming Note
    // -1
    z = read(s[1], buf, sizeof(buf));
}

void test_shutdownSocketExpectUnreadable() {
    int z;
    int s[2];
    char buf[80];
    socketpair(AF_LOCAL, SOCK_STREAM, 0, s);
    write(s[1], "dead", 4);
    z = shutdown(s[0], 0);
    assert(0 == z);
    close(s[0]);
    close(s[1]);
}

int main(int argc, char **argv) {
    RunTinyTests();
    return 0;
}

