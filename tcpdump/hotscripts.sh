#!/usr/bin/env bash

# find out mac address: ifconfig -a 

# display all traffic on (lo) interface for the local host
# tcpdump -l -i lo
# then send some messages using netcat, the traffics will show up

# display all traffic on the network coming from or going to host 127.0.0.1
# tcpdump host 127.0.0.1

# tcpdump host 127.0.0.1 80

# tcpdump tcp port 45000

