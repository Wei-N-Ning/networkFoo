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

void test_bindSocketWithAddressExpectFail() {
    int so;

    // constants
    // 1. define them once; use the variable everywhere
    // 2. use const if possible
    // 3. use in_port_t instead of unsigned short
    const in_port_t port = 9001;
    const char *ad = "127.0.0.1";
    ssize_t status;
    struct sockaddr_in addr;

    // can not be AF_LOCAL;
    // AF_LOCAL family only supports file system path or abstract path
    addr.sin_family = AF_INET;

    // map to network order (host->network)
    addr.sin_port = htons(port);
    status = inet_aton(ad, &addr.sin_addr);
    assert(status > 0);

    // can not be PF_LOCAL for similar reason
    so = socket(PF_INET, SOCK_STREAM, 0);
    assert(-1 != so);
    status = bind(so, (struct sockaddr *)&addr, sizeof(addr));
    assert(0 == status);

    // there is a common problem in the recent Linux distro,
    // search for:
    // bound but not listening

    // if a socket has been bound to an address (with a port
    // number) but is not in the state of listening, it does
    // not show up in netstat, ss, lsof
    // therefore there is no way to assert/verify the result
    // of bind() here

    // netcat -l 9001 will block on listen and its activity
    // shows up correctly

    // Red hat acknowledges that it is an issue.
    close(so);
}

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
