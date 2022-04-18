#!/usr/bin/env bash

# source: <https://github.com/trimstray/test-your-sysadmin-skills#simple-questions>
# how to check the default route table
route -n 
# Using the commands netstat -nr, route -n or ip route show we can see the default route and routing tables.

# also recall arp -a

# on DA-DELL
: '
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         192-168-1-1.tpg 0.0.0.0         UG    600    0        0 wlp59s0
link-local      0.0.0.0         255.255.0.0     U     1000   0        0 wlp59s0
172.16.176.0    0.0.0.0         255.255.255.0   U     0      0        0 vmnet8
172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0
192.168.1.0     0.0.0.0         255.255.255.0   U     600    0        0 wlp59s0
192.168.35.0    0.0.0.0         255.255.255.0   U     0      0        0 vmnet1
'

# U: Up
# U: defined by my network interface
# UG: gateway address
# destination=default/0.0.0.0 means internet
# anything else lives in wlp59s0

# story:
# source: networking for web developer talk

# client wants to go to internet server
# client asks for the router's MAC addr
# gets the MAC addr back
# sends an ethernet packet to the router,
# which holds a TCP/IP packet for the remote server
# router sends it to the next router, by making a new ethernet packet
# putting the ip packet inside, 
# the next router follows suit...
# till the ip packet reaches the server
# so happens to the return packet