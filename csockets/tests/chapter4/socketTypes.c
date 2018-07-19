
#include <unistd.h>
#include <sys/socket.h>
#include <assert.h>

void RunTinyTests();

// By Example P121
// PF_LOCAL is preferred to AF_LOCAL while invoking
// the socket creation functions (socketpair() ,
// socket() ); the AF_LOCAL series of macros
// should be used when initializing the socket
// address structures.

// when a socket is created, it is nameless (without
// an address). A valid socket address must be
// set up and the function bind() called to give
// the socket and address
// (interestingly, recall various similar "bind"
// mechanism in other C libraries, such as OpenGL)
//
// can not read from or write to this socket
// recall SOCK_STREAM requires a connection,
// see Socket By Example P125

void test_createPFLocalStreamSocket() {
    // By Example P123

    // A stream in the socket sense is the same concept that
    // applies to a UNIX pipe.

    // Bytes written to one end of the pipe (or socket) are
    // received at the other end as one continuous stream
    // of bytes. There are ///no dividing lines or boundaries///

    // there is no record length, block size or concept of
    // a packet at the receiving end. Whatever data is
    // currently available at the receiving end is returned
    // in the caller's buffer

    int s;
    ssize_t sz;
    char buf[16] = "there";

    // By Example P122
    // int socket( int domain, int type, int protocol );
    // 1: the protocol family to use
    // 2: the type of the socket required (STREAM e.g.)
    // 3: specific protocol to use within the protocol family
    s = socket(PF_LOCAL, SOCK_STREAM, 0);
    assert(-1 != s);

    // not connected - read/write are rejected
    sz = write(s, buf, sizeof(buf));
    assert(-1 == sz);
    sz = read(s, buf, 3);
    assert(-1 == sz);

    assert(0 == close(s));

    // By Example P124
    // important properties of SOCK_STREAM:

    // 1. no boundary (sending 25 + 30 bytes, the receiver may
    // get 25 then 30 or get 55 in one go)

    // 2. byte sequence order is preserved

    // 3. data is guaranteed to be received; if failure occurs,
    // an error is reported after all reasonable attempts at
    // recovery have been made; the error will be made to the
    // writing end as well
}

// By Example P125
// Properties of SOCK_DGRAM:

// packets are delivered, possibly out of order at the receiving
// end

// packets might be lost; no attempt to recover; not known to
// receiving end

// datagram packets have practical size limits

// packets are sent to remote processes in an unconnected
// manner. This permits a program to address its message to a
// different remote process, with each message written to the
// same socket

// P125-P126
// packets can also be lost if they are unsuitably large; or
// router lacks the buffer space to pass it

void test_createPFLocalDGramSocket() {
    int s;
    s = socket(PF_LOCAL, SOCK_DGRAM, 0);
    assert(-1 != s);
    assert(0 == close(s));

    // By Example P126
    // SOCK_DGRAM does not imply a connection, each time you
    // send a message with your socket, it can be destined for
    // another recipient. This property of the SOCK_DGRAM type
    // makes it attractive and efficient.
    // *recall wt's winstrumentation and other UDP applications
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
