//
// Created by wein on 7/22/18.
//

#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>

#include <assert.h>
#include <memory.h>
#include <stdio.h>

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
}

int main() {
    int s = createAndBindSocket("127.0.0.1", 9001);
    struct sockaddr_in sender;  // to be populated by recvfrom()
    socklen_t senderLen = sizeof(sender);  // updated by recvfrom()

    size_t messageLen = 512;
    char message[messageLen];
    memset(message, 0, messageLen);

#ifdef SERVER
    receive(s, messageLen, message, &sender, &senderLen);
#endif

    printf("%s\n", message);

    close(s);
    return 0;
}