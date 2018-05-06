#!/usr/bin/env bash

function activeTCPConnections() {
    netstat -ant
}

function activeUDPConnections() {
    netstat -anu
}

activeTCPConnections | wc -l
activeUDPConnections | wc -l
