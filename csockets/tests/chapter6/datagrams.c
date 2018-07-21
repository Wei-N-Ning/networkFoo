
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>

// Linux Socket By Example P163
// Finally there is the issue of datagram size.
// The theoretical maximum size of a UDP datagram is slightly less than 64KB.
// However many UNIX hosts will only support a maximum near 32KB.
// # NOTE {
// For comparison, here is the size of a json blob:
// oz app dump --av=athenaPlugins-1.13.1 | wc -c
// 3865 (bytes) ~ 3KB
//}

void RunTinyTests();

void test_nothing() {
    int z;
    char *serverAd = NULL;
    struct sockaddr_in addr;
    struct sockaddr_in addrClient;
    int len_inet;
    int so;
}

int main(int argc, char **argv) {
    RunTinyTests();
    return 0;
}


