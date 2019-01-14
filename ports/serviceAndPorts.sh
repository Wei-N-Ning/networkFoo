#!/usr/bin/env bash

# warning: result is VERY long!
function run() {
    # NOTE: works on mac
    cat /etc/services | awk '
{ 
    split($2, arr, "/")
    if (length(arr) == 2 && arr[2] != "") {
        print arr[1], arr[2]
    }
} 
'
}

run
