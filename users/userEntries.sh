#!/usr/bin/env bash

function showUserEntries() {
    getent passwd | grep ${USER}
}

showUserEntries