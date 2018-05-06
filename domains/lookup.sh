#!/usr/bin/env bash

function digForIP() {
    dig -x "107.170.4.117"
}

function hostForIP() {
    host "107.170.4.117"
}

digForIP
hostForIP
