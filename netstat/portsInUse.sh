#!/usr/bin/env bash

function run() {
    netstat -lnp
}

all_ports_in_use() {
    # https://askubuntu.com/questions/538208/how-to-check-opened-closed-ports-on-my-computer
    netstat -atn
}

run
all_ports_in_use
