//
// Created by wein on 6/23/18.
//

#include <assert.h>
#include <signal.h>
#include <memory.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

#include <sys/socket.h>
#include <sys/un.h>

void bail(const char* on_what) {
    perror(on_what);
    exit(1);
}

int createLocalSocket() {
    int sck_unix = socket(AF_LOCAL, SOCK_STREAM, 0);
    if (sck_unix == -1) {
        bail("socket(AF_LOCAL, SOCK_STREAM, 0)\n");
    }
    return sck_unix;
}

// return the length of the struct
// note it is not necessary the size of the struct
// different domain family may have different
// address length
socklen_t initSocket(struct sockaddr_un* adr_unix, const char* path, size_t path_len) {
    memset(adr_unix, 0, sizeof(struct sockaddr_un));
    adr_unix->sun_family = AF_LOCAL;
    strncpy(adr_unix->sun_path, path, path_len);
    return (socklen_t)SUN_LEN(adr_unix);
}

void run_example(int toInteract) {
    int status;
    struct sockaddr_un adr_unix;
    socklen_t len_unix = 0;
#ifdef USE_ABSTRACT_ADDR
    char pth_unix[] = "Ziddqd-idfka";
    size_t pth_len = strlen(pth_unix);
#else
    char pth_unix[] = "/tmp/my_socket";
    size_t pth_len = strlen(pth_unix);
#endif
    int sck_unix = createLocalSocket();

    len_unix = initSocket(&adr_unix, pth_unix, pth_len);
#ifdef USE_ABSTRACT_ADDR
    // this needs to be done after SUN_LEN
    adr_unix.sun_path[0] = '\0';
#else
    // AF_LOCAL address results in a file system object being
    // created; it must be removed when it is no longer required
    // Using abstract local address avoids this issue
    unlink(pth_unix);
#endif
    status = bind(sck_unix, (struct sockaddr *)&adr_unix, len_unix);
    if (status == -1) {
        bail("bind(sck_unix, (struct sockaddr *)&adr_unix, len_unix)\n");
    }
    if (toInteract) {
        // give the caller a chance to inspect and
        // interact with the socket
        kill(getpid(), SIGSTOP);
    }

    close(sck_unix);
#ifdef USE_ABSTRACT_ADDR
#else
    unlink(pth_unix);
#endif
}

int main(int argc, char** argv) {
    run_example(argc == 1 ? 0 : 1);
    printf("done\n");
    return 0;
}