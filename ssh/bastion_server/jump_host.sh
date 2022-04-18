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

jump_host_ec2() {
    # //// IMPORTANT: the network setup ////
    # in this case, both the jump host and target are in the 
    # same security group - this is bad,
    # SG inbound: 22 (anywhere); 2222 (vpc)
    # SG outbound: https (anywhere, this is for ssm); 
    #              ephemeral ports (1024-65535, vpc, this is to 
    #              allow outbound TCP traffic from jump to target)
    # NACL is default, allowing any in and out traffic
    #  

    # connect to the target ec2 via SSM web dashboard, and run
    sudo /usr/sbin/sshd -p 2222 -d

    # jump to target
    # ubuntu@13.236.135.223: user@jump (public ip)
    # ubuntu@10.0.1.54: user@target (private ip)
    ssh -A -J ubuntu@13.236.135.223 ubuntu@10.0.1.54 -p 2222

    # to verify on the target
    curl http://169.254.169.254/latest/meta-data/instance-id
}