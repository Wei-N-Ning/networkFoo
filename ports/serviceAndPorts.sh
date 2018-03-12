#!/usr/bin/env bash

function run() {
    cat /etc/services | awk '
{ 
    split($2, arr, "/")
    if (length(arr) == 2 && arr[2] != "") {
        print arr[1], arr[2]
    }
} 
' > /dev/null
}

run
