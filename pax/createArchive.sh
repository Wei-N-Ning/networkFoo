#!/usr/bin/env bash

function createMockDirTree() {
    rm -rf /tmp/proj
    mkdir /tmp/proj
    mkdir /tmp/proj/A
    echo "{}" > /tmp/proj/A/conf.json
    mkdir /tmp/proj/A/B
    echo "{}" > /tmp/proj/A/B/conf.json
}

function createArchive() {
    cd /tmp/proj
    pax -wf /tmp/proj.pax /tmp/proj
    pax -f /tmp/proj.pax
}

createMockDirTree
createArchive

