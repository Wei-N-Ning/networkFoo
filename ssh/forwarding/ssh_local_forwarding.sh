#!/usr/bin/env bash

# motivation
# simulate a jump/bastion server setup
# pub --(ssh)--> bastion --(ssh)-> VM

# source:
# https://www.ssh.com/ssh/tunneling/example
# 
# example:
# terraformFoo/aws_vpc_take1
# NOTE:
# - bastion and vm are both in public subnet (for simplicity);
#   in the test I uses the private IP address to access the VM
# - security group ingress rule:
#   22 -> 32145
#   22 is visitor's port (ssh); 32145 is the port forwarded

establish_ssh_forwarding() {
    # after terraform apply and both instances are running:
    # ubuntu@13.211.3.235 - user and public IP of the bastion server
    # 10.0.1.201: private VM's private IP 
    # 32145: a port that is open on bastion (ingress rule allows)
    # 22: the VM's default ssh port
    # -A use ssh agent forwarding, because both instances require key pair
    # -N: do not run command - this is necessary for me and without this 
    #     ssh goes ahead logging into the VM instead of listening for conns
    # -L: the forwarding argument
    ssh -A -N -L 32145:10.0.1.201:22 ubuntu@13.211.3.235

    # this command should not return
}

test_tunneling() {
    # make sure ssh-add -l still shows my rsa fingerprint 
    ssh ubuntu@localhost -p 32145

    # this command is seemingly to connect to ubuntu@localhost at 
    # port 32145, but it jumps on to the private VM via port 22 

    # test 1: remove all entries in ssh-agent, 
    # can not connect anymore

    # test 2: from another host (gunship), trying to connect:
    # ssh ubuntu@192.168.0.7 -p 32145
    # CAN NOT connect

    # i need to move this ssh-tunnel to the bastion server 
    # and instead of connecting localhost, ssh-to the server
    # this is the next step
}