#!/usr/bin/env bash

function listConnectionWithProgramName() {
    netstat -tulpn 2>/dev/null | awk '
$7 ~ /[^\-]+/ {
    print
}
'
}

listConnectionWithProgramName
