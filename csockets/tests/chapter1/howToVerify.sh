#!/usr/bin/env bash

# source:
# man 7 signal (SIGCONT)
# man 2 kill (kill(self, sig))
#   see also: https://cboard.cprogramming.com/linux-programming/132657-how-correctly-continue-paused-process.html

# side notes:
# pause() requires signal handler
# man pause
#
# to "create custom signals"
# https://www.linuxquestions.org/questions/programming-9/sigaction-how-to-create-custom-signals-362414/
# it is really to avoid using fancy signals (but sockets or pipes instead)
#
# bash wait only waits for child proc to terminate:
# https://unix.stackexchange.com/questions/92419/wait-command-usage-in-linux
# there is no pause in bash
# I have to look at other places to implement an event driven model

CC=cc

buildProgram() {
    cat > /tmp/_.c <<EOF
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>

int main() {
    int tmp[2];
    socketpair(AF_LOCAL, SOCK_STREAM, 0, tmp);
    kill(getpid(), SIGSTOP);
    close(tmp[0]);
    close(tmp[1]);
    return 0;
}
EOF
    ${CC} -Wall -Werror /tmp/_.c -o /tmp/thereisacow
}

buildProgram
/tmp/thereisacow &
child_pid=${!}
sleep 0.1
netstat --unix -p 2>/dev/null | grep -P --color 'thereisacow'
kill -SIGCONT ${child_pid}
wait
