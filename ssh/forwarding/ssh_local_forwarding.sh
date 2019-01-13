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

    # test 3: ctrl+c terminates the ssh -L process, and try ssh-to
    # ubuntu@localhost; connection is refused

    # i need to move this ssh-tunnel to the bastion server 
    # and instead of connecting localhost, ssh-to the server
    # this is the next step
}

run_forwarding_on_local_macbook() {
    # read this:
    # https://unix.stackexchange.com/questions/115897/whats-ssh-port-forwarding-and-whats-the-difference-between-ssh-local-and-remot
    # the improvement in this test is that, other host in my network (gunship) 
    # can also use the bastion srv to ssh-to the private VM:
    # on gunship: 
    # > ssh-add the private key (mortalengine)
    # > ssh -A ubuntu@192.168.0.7 -p 32145
    ssh -A -N -L 192.168.0.7:32145:10.0.1.201:22 ubuntu@13.211.3.235
}

run_forwarding_on_bastion() {
    # this to run the ssh -L process on bastion srv
    # the above article helps me again
    # and the key is here:
    # The star implies that you listen on all addresses, 
    # and not localhost, which you cannot connect to from other machines.
    # https://serverfault.com/questions/910526/ssh-local-port-forwarding-working-from-localhost-only
    #  
    ssh -A -N -L *:32145:10.0.1.201:22 localhost
    #            ^^^^^^^
    # previously I hardcoded the IP address of the machine that ran
    # the forwarding command to my local macbook's IP address; 
    # this time this address is a wildcard meaning any address is allowed
    # localhost:32145 will not work because other machines can not 
    # connect to "localhost" (loopback interface) from outside
    # the forwarder is localhost 

    # to verify on gunship:
    # > ssh-add mortalengine private key
    ssh -A ubuntu@13.211.3.235 -p 32145

    # note that one can still log on to the bastion server via normal
    # ssh port:
    ssh -A ubuntu@13.211.3.235
}

