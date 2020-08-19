#!/usr/bin/env bash

# sends a series of test packets to experimentally determine
# the current route to a host

# this is performed by incrasing the IP protocol time to live (TTL)
# by one for each packet, causing the sequence of gateways
# to the host to reveal themselves by sending ICMP time
# exceeded response messages

# the path taken can be also studied as part of static perf
# tuning.

# like ping, can omit the 0s inbetween
traceroute 1.1
traceroute -n google.com

# Unix/Linux traceroute uses udp (not icmp); windows uses icmp; 
# observe this:
sudo tcpdump -v -i wlp59s0 src 192.168.1.106 and dst 1.0.0.1 and udp

# there is clearly some caching going on!
# ttl is incremented per route

# let traceroute use icmp packets instead
sudo traceroute -I 1.1
