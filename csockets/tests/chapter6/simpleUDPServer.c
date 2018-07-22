//
// Created by wein on 7/22/18.
//

#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>

#include <assert.h>
#include <memory.h>
#include <stdio.h>
#include <stdlib.h>

int createAndBindSocket(const char* i_addrStr, unsigned short i_port) {
    struct sockaddr_in addr;
    size_t addrLen = sizeof(addr);
    memset(&addr, 0, addrLen);
    addr.sin_family = PF_INET;
    addr.sin_addr.s_addr = inet_addr(i_addrStr);
    addr.sin_port = htons(i_port);
    int s = socket(PF_INET, SOCK_DGRAM, 0);
    assert(-1 != s);
    assert(
        -1 != bind(s, (struct sockaddr *)&addr, (int)addrLen)
    );
    return s;
}

// By Example P166
// (notes on recvfrom())
// the companion to the sendto() function is recvfrom function;
// this function differs from read() function in that it allows you to
// receive the sender's address at the same time you receive your
// datagram.

// P172
// (notes on recvfrom())
// this function call will block until the server receives a datagram
// upon return from this function, o_buffer will contain the datagram ,
// and return value will be the size of this  datagram (or -1 if there
// was an error returned)
// the sender's socket address is returned in structure o_sender and
// variable io_senderLen is set to the length of the address in
// o_sender

int receive(
    int i_socket,
    size_t i_bufferLen,
    void* o_buffer,
    struct sockaddr_in* o_sender,
    socklen_t* io_senderLen
) {
    ssize_t bytesReceived = recvfrom(
        i_socket,
        o_buffer,
        i_bufferLen,
        0,
        (struct sockaddr *)o_sender,
        io_senderLen
    );
    assert(bytesReceived >= 0);

    // By Example P172
    // the recommended way is to set a 0 character
    // o_buffer[result] = 0;
    return 1;
}

int main(int argc, char** argv) {

    // By Example 173
    // if you run the server with a different IP address, if you don't
    // have an interface with this number you will get an error
    // (can not assign request address)
    //
    // however when using the 127.0.0.1 network (local loopback device
    // you can specify any class A address, if it starts with 127
    // (the example in the book uses 127.0.0.23; my test uses
    // 127.0.0.123)

    int s = -1;
    if (argc == 3) {
        s = createAndBindSocket(argv[1], (unsigned short)atoi(argv[2]));
    } else {
        s = createAndBindSocket("127.0.0.1", 9001);
    }

    struct sockaddr_in sender;  // to be populated by recvfrom()
    socklen_t senderLen = sizeof(sender);  // updated by recvfrom()

    size_t messageLen = 512;
    char message[messageLen];
    memset(message, 0, messageLen);

#ifdef SERVER
    receive(s, messageLen, message, &sender, &senderLen);
#endif

    printf("client (%s:%d) message: %s\n",
           inet_ntoa(sender.sin_addr),
           sender.sin_port,
           message);

    close(s);
    return 0;
}