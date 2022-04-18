#!/usr/bin/env bash

# source: ssh mastery L863
cli_conf_inline() {
    # set the configure key=value in the command line
    ssh -o Port=2222 "user@address"
}
