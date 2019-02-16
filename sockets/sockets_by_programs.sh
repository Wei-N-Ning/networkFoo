#!/usr/bin/env bash

# $1: name of the program (e.g. java)
# to show the TCP/UDP sockets on which a running program
# which contains the string ${1} is listening to

#-n
#no port to name resolution
#-l
#only listening sockets
#-p
#show processes listening
#-u
#show udp sockets
#-t
#show tcp sockets

function run() {
    if [ "$1" == "" ]
    then
        ss -nlput
    else
        ss -nlput | grep $1
    fi
}

run "java"
