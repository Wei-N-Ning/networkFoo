#!/usr/bin/env bash

# source:
# https://unix.stackexchange.com/questions/54975/how-to-check-that-a-daemon-is-listening-on-what-interface
run() {
    local address=${1:-127.0.0.1}
    for i in $(grep ':' /proc/net/dev | cut -d ':' -f 1 | tr -d ' ') ; do
            if $(ip address show dev ${i} | grep -q "${address}") ; then
                    echo "${address} found on interface ${i}"
            fi
    done
}

run $@
