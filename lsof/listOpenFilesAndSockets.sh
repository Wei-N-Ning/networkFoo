#!/usr/bin/env bash

function givenPID() {
    lsof -p $( pgrep konsole )
}

function run() {
    givenPID
}

run
