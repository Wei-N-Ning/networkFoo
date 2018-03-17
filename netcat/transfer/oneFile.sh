#!/usr/bin/env bash

function assertExists() {
    if [ ! -f $1 ]
    then
        echo "file does not exist: $1"
        exit 1
    fi
}

function startListening() {
    nc -lvp 9000 > $1 &
}

function doPing() {
    nc 127.0.0.1 9000 < $1
}

function run() {
    local fileAtSrc="/tmp/_"
    echo "" > ${fileAtSrc}

    local fileAtDst="/tmp/__"
    rm -f ${fileAtDst}

    startListening ${fileAtDst}
    sleep 0.1
    doPing ${fileAtSrc}

    assertExists ${fileAtDst}
}

run
