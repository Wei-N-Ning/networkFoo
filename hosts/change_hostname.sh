#!/usr/bin/env bash

# works on centos 7 and u18
do_change_hostname() {
    # require password
    hostnamectl set-hostname <custom-hostname>
}

