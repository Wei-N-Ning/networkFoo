#!/usr/bin/env bash

function showUserEntries() {
    # works on centos 7 and u18, NOT on mac
    getent passwd | grep ${USER}
}

showUserEntries