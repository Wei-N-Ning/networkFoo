#!/usr/bin/env bash

# source: ssh mastery L875
jump_host_example() {
    ssh -J wein@192.168.0.16 tom@192.168.0.12
    # wein@192.168.0.16 uses public key to authenticate
    # tom@192.168.0.12 uses password to authenticate

    # from the book:
    # "I will get prompted for my authentication credentials
    # on the jump host, and then my credentials on the dest 
    # it is best to use public key authentication on both
    # hosts"

    # need a more realistic example

    # set a jump host in ssh_config:
    Host destuser@dest
    ProxyJump jumpuser@address
}

