#!/usr/bin/env bash

function givenPID() {
    lsof -i -n -P -p $( pgrep konsole )
}

function run() {
    givenPID
}

run
