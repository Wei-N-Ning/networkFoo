
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>

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


