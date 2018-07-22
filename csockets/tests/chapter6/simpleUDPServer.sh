#!/usr/bin/env bash

CC=gcc
SRC=./simpleUDPServer.c
BIN=/tmp/sut/out

setUp() {
    set -e
    rm -rf /tmp/sut
    mkdir /tmp/sut
}

buildProgram() {
    ${CC} -DSERVER ${SRC} -o ${BIN}
}

runProgram() {
    ${BIN} &
    sleep 0.1

    echo "iddqd" | netcat -w 0 -u 127.0.0.1 9001
    wait
}

setUp
buildProgram
runProgram
