#!/usr/bin/env bash

function listSshAgents() {
    ps -ALL | grep ssh-agent | awk -c 'NF > 2 && /^[ 0-9]+/ { print $1 }'
}

function run() {
    listSshAgents
}

run
