#!/usr/bin/env bash

# source: SSH definitive 2nd P/308

# A single SSH connection can have multiple channels simultaneously 
# supporting a variety of services...
# setting up an SSH connection is a computationally expensive process
# given that SSH can use channels, wouldn't it be better to set up 
# one SSH connection to a given host, and then somehow issue our 
# various commands over that one session?

# see also man ssh
#  -M      
# Places the ssh client into ``master'' mode for connection 
# sharing.  Multiple -M options places ssh into ``master'' 
# mode with confirmation 
# required before slave connections are accepted.  
# Refer to the description of ControlMaster in ssh_config(5) 
# for details

shared_connection() {
    # use CA's dev.jump host as the test subject
    # the destination host must be the same

    # opens an connection, placing it in the background
    # also tells the SSH process to act as the master process
    # allowing other ssh invocations (its slaves) to open channels
    # ot this server through it
    # master and slaves comnunicate via the unix domain socket 
    # specified by the filename
    ssh -S /var/tmp/master -M -F ~/.ssh/dev.jump.config dev.jump

    # open remote term much quicker (compare this with normal ssh)
    ssh -S /var/tmp/master -F ~/.ssh/dev.jump.config dev.jump

    # enables this via config
    # ~/.ssh/config
    #  host snowcrash-master
    #    hostname snowcrash.neal.org
    #    ControlPath /tmp/ssh-snowcrash
    #    ControlMaster
    #  host snowcrash-slave
    #    hostname snowcrash.neal.org
    #    ControlPath /tmp/ssh-snowcrash
}






