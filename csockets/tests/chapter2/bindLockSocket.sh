#!/usr/bin/env bash

CC=cc
CHILD_PID=

setUp() {
    set -e
    rm -rf /tmp/sut
    mkdir /tmp/sut
}

buildProgram() {
    ${CC} -Wall -Werror ./bindLocalSocket.c -o /tmp/sut/thereisacow
}

buildProgramEnableAbstractAddress() {
    ${CC} -Wall -Werror -DUSE_ABSTRACT_ADDR=1 ./bindLocalSocket.c -o /tmp/sut/thereisacow
}

runProgramAndStop() {
    /tmp/sut/thereisacow 1 &
    CHILD_PID=${!}
    sleep 0.1
}

inspect() {
    netstat -pa --unix 2>/dev/null |
    grep -P --color '^Proto|thereisacow'
}

setUp
buildProgram
runProgramAndStop
inspect
kill -s CONT ${CHILD_PID}
wait

buildProgramEnableAbstractAddress
runProgramAndStop
inspect
kill -s CONT ${CHILD_PID}
wait
