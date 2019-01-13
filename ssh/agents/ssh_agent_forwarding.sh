#!/usr/bin/env bash

# motivation:
# in this setup:
# visitor -> [bastion] -> [private vm]
# how can one avoid leaving private key in the bastion server?
# (given that, both bastion and private-vm require ssh key at login)

# source:
# https://dev.to/levivm/how-to-use-ssh-and-ssh-agent-forwarding-more-secure-ssh-2c32

# example: terraformFoo/aws_vpc_take1
# two public instances, one acting like bastion srv;
# the goal is, when login to the private-vm at the bastion srv, one does 
# not private the key

ensure_ssh_agent_running() {
    eval `ssh-agent`  

    # 
}

add_local_keypair() {
    ssh-add
    ssh-add -l
}

login_bastion() {
    ssh -A user@...

    # at the bastion srv, one can directly login to the private vm without
    # providing the private key (again)
    ssh user@pri...
}

