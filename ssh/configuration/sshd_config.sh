#!/usr/bin/env bash

# disable root user login is to avoid brutal-force 
# attack on known account;
# sudoer account can be less known hence safer
# I must make sure the sudoer(s) are well setup

disable_root_login() {
    grep PermitRootLogin /etc/ssh/sshd_config

    # change 

    sudo systemctl restart sshd
    sudo systemctl status sshd
}