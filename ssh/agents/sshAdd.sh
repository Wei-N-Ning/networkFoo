#!/usr/bin/env bash

# the goal of this script is not to call ssh-add but to
# generate a command line for tcsh

# to explicitly create and bind an agent to a named
# address (UNIX-domain) socket bind-address if no
# such an agent exists; otherwise reuse the existing
# agent by simply copy the PID and bind-address to
# the corresponding environment variables
# after that, prompt ssh-add

# hardcoding is bad
bindAddress="/tmp/_something_something"
envVariables="/tmp/_something_something_vars"

function getCmd() {
    if [ -f ${bindAddress} ] && [ -f ${envVariables} ]
    then
        echo "found agent bind address: ${bindAddress}"
        cat ${envVariables}
    else
        echo "create an agent first!"
        echo "ssh-agent -a ${bindAddress} > ${envVariables}"
    fi
}

function setUp() {
    rm -f ${bindAddress} ${envVariables}
    echo '' > ${bindAddress}
    echo '' > ${envVariables}
}

function tearDown() {
    rm -f ${bindAddress} ${envVariables}
}

function runTests() {
    getCmd
}

getCmd
setUp
runTests
tearDown
