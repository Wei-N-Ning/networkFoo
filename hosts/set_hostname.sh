#!/usr/bin/env bash

set_hostname() {
    hostname 'name'

    # permanent, source:
    # https://www.cyberciti.biz/faq/ubuntu-change-hostname-command/
    vim /etc/hostname 
}
