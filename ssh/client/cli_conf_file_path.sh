#!/usr/bin/env bash

# use explicit configure file path
# this is used in ca code base to allow "flavored" client-side conf,
# such as ~/.ssh/kknd.config, ~/.ssh/doom.config
# the ssh command uses -F to ensure the same flavor is 
# used in both the configure file name and other parts 
conf_file_path() {
    cp ${HOME}/.ssh/config /var/tmp/cli_conf.test
    ssh -F /var/tmp/cli_conf.test "user@address" -p port
}

