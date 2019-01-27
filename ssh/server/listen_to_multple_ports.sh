#!/usr/bin/env bash

ssh_listens_to_multiple_port() {
    # read this:
    # https://ubuntuforums.org/showthread.php?t=1074080
    # SSH can listen on multiple ports, but you cannot have multiple 
    # servers listen on the same port.
    # In /etc/ssh/sshd_config simply add a second port command underneath 
    # the default one, then restart sshd. (and update your firewall to allow 
    # the new port in).
    
    # need root
    # must enable both:
    # Port 22
    # Port 32145
    sudo vim /etc/ssh/sshd_config

    # https://askubuntu.com/questions/538208/how-to-check-opened-closed-ports-on-my-computer
    netstat -atn
    # should show 32145!
}


