//
// Created by wein on 6/20/18.
//

// source
// Linux Socket By Examples, P53
// Note how to send and read the shutdown response message

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <memory.h>
#include <sys/socket.h>
#include <sys/wait.h>

typedef struct {
    int r_sock;
    int w_sock;
    int domain;
    int type;
    int protocol;
} sock_t;

sock_t* OpenSockets(int domain, int type, int protocol) {
    sock_t* sock = malloc(sizeof(sock_t));
    int tmp[2];
    assert(0 == socketpair(domain, type, protocol, tmp));
    sock->r_sock = tmp[0];
    sock->w_sock = tmp[1];
    sock->domain = domain;
    sock->type = type;
    sock->protocol = protocol;
    return sock;
}

void CloseSockets(sock_t* sock) {
    assert(0 == close(sock->w_sock));
    assert(0 == close(sock->r_sock));
}

void child_is_client(sock_t *sock) {
    char buf[32] = {'p', 'l', 'a', 'y', 'e', 'r', ' ', '1'};
    ssize_t z;
    assert(8 == write(sock->w_sock, buf, 8));
    assert(0 == shutdown(sock->w_sock, SHUT_WR));
    z = read(sock->w_sock, buf, 32);
    assert(z >= 0);
    buf[z] = 0;
    printf("  server shutdown response: %s\n", buf);
    fflush(stdout);
    CloseSockets(sock);
}

void parent_is_server(sock_t *sock) {
    char buf[32];
    memset(buf, 0, 32);
    assert(8 == read(sock->r_sock, buf, 8));
    printf("welcome client: %s\n", buf);
    fflush(stdout);
    buf[0] = 'D';
    buf[1] = 'E';
    assert(2 == write(sock->r_sock, buf, 2));
    CloseSockets(sock);
}

int main() {
    int status;
    sock_t* sock = OpenSockets(AF_LOCAL, SOCK_STREAM, 0);
    pid_t child_pid = fork();
    if (child_pid == (pid_t)-1) {
        perror("fork(2) failed\n");
        CloseSockets(sock);
        free(sock);
        exit(1);
    }
    if (child_pid == 0) {
        child_is_client(sock);
    } else {
        parent_is_server(sock);
        waitpid(child_pid, &status, 0);
    }
    free(sock);
    return 0;
}