#!/usr/bin/env bash

# source
# sshd master L325

test_sshd_config() {
    # validate/test the server config file
    /usr/sbin/sshd -t -f /path/to/conf.test
}
