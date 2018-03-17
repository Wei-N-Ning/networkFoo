//
// Created by wein on 3/17/18.
//

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <assert.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <arpa/inet.h>

void RunTinyTests();

void xtest_bindSocketWithAddressExpectFail() {
    int so;
    const char *ad = "127.0.0.24";
    ssize_t status;
    struct sockaddr_in addr;

    // can not be AF_LOCAL (since it only takes file system path or abstract path)
    addr.sin_family = AF_INET;
    addr.sin_port = htons(9001);
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);

    // can not be PF_LOCAL
    so = socket(PF_INET, SOCK_STREAM, 0);
    assert(-1 != so);
    status = bind(so, (struct sockaddr *)&addr, sizeof(addr));
    assert(0 == status);

    close(so);
}

void test_getSocketName() {
    int so;
    const char *ad = "127.0.0.24";
    in_port_t port = 9989;
    ssize_t status;
    struct sockaddr_in addr;
    struct sockaddr_in recv;
    socklen_t recvLen = sizeof(recv);
    memset(&addr, 0, sizeof(addr));
    memset(&recv, 0, recvLen);

    so = socket(PF_INET, SOCK_STREAM, 0);
    assert(-1 != so);

    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    status = inet_aton(ad, &addr.sin_addr);
    assert(status > 0);

    status = bind(so, (struct sockaddr *)&addr, sizeof(addr));
    assert(0 == status);

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
