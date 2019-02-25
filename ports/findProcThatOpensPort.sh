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
