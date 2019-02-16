#!/usr/bin/env bash

# -n: no DNS look up ('cos the IP is known)
# 1-1000: slower than nmap
# -z: perform a scan, but not attempting to connect
# 2>&1:
# the messages returned are sent to stderr, hence the
# redirection

function run() {
    nc -z -n -v 127.0.0.1 1-1000 2>&1 | perl -lne \
        '/Connection to(.*)succeeded/ && print $1'
}

run
