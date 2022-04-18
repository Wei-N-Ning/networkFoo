#!/usr/bin/env bash

start_forwarding() {
    # 13.236.135.223 is the public IP of 
    #  an Amazon ec2 running ubuntu image
    # once successful, it will prompt a login 
    # on ec2 and start a new ssh session
    # use -N to avoid starting a new ssh session
    # -N: Do not execute a remote command.  This is useful for 
    #     just forwarding ports
    ssh -L 2222:localhost:22 ubuntu@13.236.135.223
}

ssh_via_new_port() {
    # using the forwarded port 2222
    # one can login to ec2 via localhost
    # -A is to forward the agent, assume that 
    # user's .pem file has been added via ssh-add
    ssh -A ubuntu@localhost -p 2222
}

scp_via_new_port() {
    # binfile.bin is a test file in the current directory
    # NOTE scp use -P (uppercase) instead of -p
    # I don't need to specify -A (there is no such an option in
    # scp)
    # note that the version of scp on Linux (U18) does not 
    # support the scp protocol scp:// (unlike Mac OS)
    scp -P 2222 binfile.bin ubuntu@localhost:'/var/tmp'
}
