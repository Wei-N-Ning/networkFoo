#!/usr/bin/env bash

function createMockDirTree() {
    rm -rf /tmp/proj
    mkdir /tmp/proj
    mkdir /tmp/proj/A
    echo "{}" > /tmp/proj/A/conf.json
    mkdir /tmp/proj/A/B
    echo "{}" > /tmp/proj/A/B/conf.json
}

# note the direction is: ssh SOURCE DEST
function run() {
    rsync -ave ssh /tmp/proj wein@107.170.4.117:/tmp/proj
}

createMockDirTree
run

