#!/usr/bin/env bash

# good reference:
# https://github.com/wwalker/ssh-find-agent/blob/master/ssh-find-agent.sh

function listSshAgentPids() {
    ps -ALL | grep ssh-agent | awk -c 'NF > 2 && /^[ 0-9]+/ { print $1 }'
}

function getParentPid() {
    ps -o ppid= -p ${1:-"require pid"}
}

function run() {
    local parentPid=""
    for saPid in $( listSshAgentPids )
    do
        parentPid=$( getParentPid ${saPid} )
        printf "%s, parent is %s" ${saPid} ${parentPid}
    done
}

run
