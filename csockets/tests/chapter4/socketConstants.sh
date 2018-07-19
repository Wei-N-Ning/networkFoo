#!/usr/bin/env bash

# Socket By Example P121
# the best advice:
# PF_LOCAL series of macros should be used in the socketpair,
# and socket domain argument;
# AF_LOCAL series of macros should be used when initializing
# the socket address structures;

function showPythonSocketProtocols() {
    python -c "
import socket
for _ in sorted([c for c in dir(socket)
    if c.startswith('AF') or c.startswith('PF')]):
    print(_)
"
}

function showPythonSocketTypes() {
    python -c "
import socket
for _ in sorted([c for c in dir(socket)
    if c.startswith('SOCK')]):
    print(_)
"
}

function run() {
    showPythonSocketProtocols
    showPythonSocketTypes
}

run
