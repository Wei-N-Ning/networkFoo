#!/usr/bin/env bash

# source
# Linux Socket Programming By Example
# P145

# this example is to workaround an issue that stops the bound sockets
# from showing up during to call to netstat (i.e. it won't work if I
# follow the example in the book)

# this example uses the signal-kill technique to interrupt the
# execution of the SUT (the child process)

# it also shows that ss is a handy application

CC=gcc

setUp() {
    set -e
    rm -rf /tmp/sut
    mkdir /tmp/sut
}

# $1: port number
buildProgram() {
    local src=/tmp/sut/_.c
    local bin=/tmp/sut/thereisacow
    local port=${1:?"missing port number"}
    cat > ${src} <<"EOF"
#include <netinet/in.h>
#include <arpa/inet.h>

#include <unistd.h>
#include <signal.h>
#include <assert.h>

int main() {
    int s = -1;
    const in_port_t port = PORT_NUMBER;
    const char* s_addr = "127.0.0.1";
    ssize_t status = -1;

    struct sockaddr_in addr;
    addr.sin_family = PF_INET;
    addr.sin_port = htons(port);
    status = inet_aton(s_addr, &addr.sin_addr);
    assert(status > 0);

    s = socket(PF_INET, SOCK_DGRAM, 0);
    assert(s > 0);

    status = bind(s, (struct sockaddr *)&addr, sizeof(addr));

    // block, give caller a chance to inspect the socket
    const char gossip[] = {0xD, 0xE, 0xA, 0xD};
    write(s, (const void *)gossip, 4);
    kill(getpid(), SIGSTOP);

    close(s);
    return 0;

}
EOF
    ${CC} ${src} -DPORT_NUMBER=${port} -o ${bin}
    echo ${bin}
}

# $1: program path
# $2: port number
runProgram() {
    local prog=${1:?"missing prog"}
    local port=${2:?"missing port"}

    ${prog} &
    local child=${!}
    sleep 0.1

    ss -ap | grep -i ${port}

    kill -SIGCONT ${child}
    wait
}

setUp
prog=$( buildProgram 9001 )
runProgram ${prog} 9001
