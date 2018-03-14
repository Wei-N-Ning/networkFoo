#!/usr/bin/env bash

function run() {
    rm -rf /tmp/doom
    mkdir /tmp/doom
    echo "iddqd idkfa" > /tmp/doom/map
    tar zcvf - /tmp/doom | ssh wein@107.170.4.117 "cat > /tmp/doom_back.tgz"
}

run

