#!/usr/bin/env bash

# source:
# https://www.networkworld.com/article/2750342/checking-your-arp-entries.html
# One useful tool for diagnosing network troubles is the arp 
# command -- a tool which allows you to display the IP address
#  to hardware (MAC) address mappings that a system has built
#  so that it doesn't have to fetch the same information 
# repeatedly for systems it communicates with


# this example relates to network for web developer talk
# the host explains why ARP is needed for sending tcp/ip packet

# on da-dell:

arp -a

# ? (169.254.169.254) at <incomplete> on wlp59s0
# 192-168-1-1.tpgi.com.au (192.168.1.1) at 1c:3b:f3:e3:fd:92 [ether] on wlp59s0
