#!/usr/bin/env bash

scp_with_ssh_config() {
    # one can pass ssh client config file via -F
    cat >/var/tmp/test_conf <<"SSH_CONFIG"
Host src
    HostName localhost
    User wein
    Port 22

Host dest
    HostName 13.236.135.223
    User ubuntu
    Port 22
SSH_CONFIG

    scp -F ./test_conf /var/tmp/binfile.bin dest:/var/tmp

    # Note that I can not feed -F a file descriptor
    # it must be a filename
}