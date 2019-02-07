#!/usr/bin/env bash

# recap in
# https://perldoc.perl.org/perlipc.html
# netstat -a
# show which services currently have servers
function activeTCPConnections() {
    netstat -ant
}

function activeUDPConnections() {
    netstat -anu
}

activeTCPConnections | wc -l
activeUDPConnections | wc -l
