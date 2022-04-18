#!/usr/bin/env bash

# source:
# https://www.cyberciti.biz/faq/what-process-has-open-linux-port/

function listConnectionWithProgramName() {
    netstat -tulpn 2>/dev/null | awk '
$7 ~ /[^\-]+/ {
    print
}
'
}

listConnectionWithProgramName
