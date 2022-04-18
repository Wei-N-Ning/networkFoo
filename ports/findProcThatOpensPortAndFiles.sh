#!/usr/bin/env bash

# source
# https://www.cyberciti.biz/faq/what-process-has-open-linux-port/

fuser_demo() {
    # fuser: identify processes using files or sockets

    fuser 7000/tcp 2>/dev/null

    # tested this in CA dev.jump host (after ssh-ing to it)
    fuser 22/tcp -v
    #                      USER        PID ACCESS COMMAND
    # 22/tcp:              root       3694 F.... sshd
    #                      ubuntu     3782 F.... sshd
    #                      root      20225 F.... sshd
}

fuser_find_prog_using_file() {
    # use netstat -lnp to find some unix domain socks in use
    # for example:
    : <<<'/run/user/1000/snap.code/vscode-5eb9ff65-1.47.3-main.sock'

    # run fuser -v with this filename
    fuser -v /run/user/1000/snap.code/vscode-5eb9ff65-1.47.3-main.sock

    # it prints out the PID, the command of the programm:
: <<"EXAMPLE"
                     USER        PID ACCESS COMMAND
/run/user/1000/snap.code/vscode-5eb9ff65-1.47.3-main.sock:
                     weining   13119 F.... code
EXAMPLE
}

