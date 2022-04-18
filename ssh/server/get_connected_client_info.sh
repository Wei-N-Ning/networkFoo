#!/usr/bin/env bash

# source: SSH definitive 2nd P/310

# after connecting to the server, ssh sets an environment var in the rmeote
# shell to hold the port info.
# for openssh, the variable is SSH_CLIENT
# 
connected_client() {
    # on CA's dev.jump
    echo "${SSH_CLIENT}"
    # 202.159.173.206 52175 22
    # client ip, client tcp port, srv tcp port
    
    # on h6 u18 virtual box
    # 192.168.0.5 52162 22

    echo "${SSH_CONNECTION}"
    # 192.168.0.5 52201 192.168.0.6 22
    
}