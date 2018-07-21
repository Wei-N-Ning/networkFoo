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

    // recall: what does _in stand for
    // and what does _un sockaddr_un stand for
    // on Linux (Ubuntu 16)
    // this struct comes from netinet/in.h header;
    // sockaddr_un struct comes from sys/un.h header;
    struct sockaddr_in addr;

    // can not be PF/AF_LOCAL;
    // PF/AF_LOCAL family only supports file system path or abstract path
    addr.sin_family = PF_INET;

    // map to network order (host->network)
    addr.sin_port = htons(port);
    status = inet_aton(ad, &addr.sin_addr);
    assert(status > 0);

    // can not be PF_LOCAL for similar reason
    so = socket(PF_INET, SOCK_STREAM, 0);
    assert(-1 != so);

    // By Example P143
    // the purpose of bind() is to assign a socket address to a nameless
    // socket;
    // the socket provided to bind must be presently nameless (without
    // an address). You can not rebind a socket to a new address.
    // note that this function receives a generic address type ( as
    // contrary to the specific INET, LOCAL address type);
    // require a cast
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

    // See bindAddressToSocket.sh for a modified demo that works
    // around this issue (binding and writing to a DGRAM socket)
    close(so);
}

int main(int argc, char **argv) {
    RunTinyTests();
    return 0;
}
