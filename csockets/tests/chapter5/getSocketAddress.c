//
// Created by wein on 7/21/18.
//

#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>

#include <assert.h>
#include <string.h>

// Source
// By Example P140-150

void RunTinyTests();

void test_getSocketName() {
    int so;
    const char *ad = "127.0.0.1";
    const in_port_t port = 13428;
    ssize_t status;
    struct sockaddr_in addr;
    struct sockaddr_in recv;
    socklen_t recvLen = sizeof(recv);

    // not completely necessary but it is a good practice to
    // always init the struct; here I init them by calling
    // the setter functions; getsockname() will populate
    // the other one

    // memset(&addr, 0, sizeof(addr));
    // memset(&recv, 0, recvLen);

    so = socket(PF_INET, SOCK_STREAM, 0);
    assert(-1 != so);

    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    status = inet_aton(ad, &addr.sin_addr);
    assert(status > 0);

    status = bind(so, (struct sockaddr *)&addr, sizeof(addr));
    assert(0 == status);

    // recvLen can not be 0 or uninitialized!
    // its value must be the actual size of struct sockaddr_in;
    // getsockname() can only manipulate this many bytes;
    // failing to do so results in a corrupted stack
    status = getsockname(so, (struct sockaddr *)&recv, &recvLen);
    assert(0 == status);
    assert(0 == strcmp(ad, inet_ntoa(recv.sin_addr)));
    assert(port == ntohs(recv.sin_port));

    close(so);
}

int main(int argc, char **argv) {
    RunTinyTests();
    return 0;
}