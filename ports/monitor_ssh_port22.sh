#!/usr/bin/env bash

# find out mac address: ifconfig -a 

# display all traffic on (lo) interface for the local host
# tcpdump -l -i lo
# then send some messages using netcat, the traffics will show up

# display all traffic on the network coming from or going to host 127.0.0.1
# tcpdump host 127.0.0.1

# tcpdump host 127.0.0.1 80

# tcpdump tcp port 45000

listen_to_ssh22_on_mac() {
    # require sudo perm
    sudo tcpdump tcp port 22

    # then in u18 vbox vm, type some characters in the shell
    # observe the output from tcpdump
}

listen_to_ssh22_on_linux() {
    # find out the ethernet interface name using ip addr
    # then start monitoring port 22 on this interface
    # (example da-dell)
    sudo tcpdump -n -i wlp59s0 tcp

    # in separate shell, ssh into the same machine, then
    # type some commands, such as ls in the login shell

    # observe the traffic from tcpdump
}
