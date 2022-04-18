#!/usr/bin/env bash

function showWhos() {
    # works on mac and linux; formats are different
    who -a
}

function showWhoAndWhatDoing() {
    w
}

showWhos
showWhoAndWhatDoing
