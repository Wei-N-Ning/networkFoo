#!/usr/bin/env bash

# note
# observe the sender's address and port each time this demo runs:
# client (127.0.0.1:31366) message: iddqd
# the address is localhost, but the port is randomly chosen (by netcat)

CC=gcc
SRC=./simpleUDPServer.c
BIN=/tmp/sut/out
SRV_ADDR=127.0.0.123
SRV_PORT=9001

setUp() {
    set -e
    rm -rf /tmp/sut
    mkdir /tmp/sut
}

buildProgram() {
    ${CC} -DSERVER ${SRC} -o ${BIN}
}

runProgram() {
    ${BIN} ${SRV_ADDR} ${SRV_PORT} &
    sleep 0.1

    echo "iddqd" | netcat -w 0 -u ${SRV_ADDR} ${SRV_PORT}
    wait
}

setUp
buildProgram
runProgram
