#!/usr/bin/env bash

# use explicit configure file path
conf_file_path() {
    cp ${HOME}/.ssh/config /var/tmp/cli_conf.test
    ssh -F /var/tmp/cli_conf.test "user@address" -p port
}

