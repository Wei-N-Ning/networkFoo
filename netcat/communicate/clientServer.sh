#!/usr/bin/env bash

function sendMessageMustFail() {
    echo "s" | nc 127.0.0.1 9988
    if [ $? == 0 ]
    then
        echo "unexpected"
        exit 1
    fi
}

function sendMessage() {
    # start server (listening)
    nc -l 9988 &

    sleep 0.1

    # ping server (client)
    echo "s" | nc 127.0.0.1 9988
}

sendMessageMustFail
sendMessage
