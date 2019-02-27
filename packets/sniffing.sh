#!/usr/bin/env bash

# source
# networking for system admin L1711
# a packet sniffer displays packets as they cross a network 
# interface.
# the sniffer can capture and display everything that arrives 
# from the network and everything that leaves the server.

# tcpdump

# the filtering language created for tcpdump, Berkeley Packet 
# Filter (BPF) syntax, has become a standard port of network
# Almost every packet sniffer supports tcpdump-style BPF
# expressions.

# wireshark

# is a newer, fancier packet sniffer, it is really a traffic
# analysis tool. It can automatically decode many network
# protocols for you, reassemble complex data streams

# modern operating systems run tcpdump in a sandbox to 
# explicitly prevent this problem (being subverted by malicious 
# code in privilege mode. Tcpdump exploit traffic is almost
# unknown outside the lab in any event.

# L1888
# you try to connect to a network service from your desktop and nothing
# happends, 
# - has the server process hung ?
# - is the client traffic even reaching the server?
# 
# when you connect to a network socket, the operating system kernel 
# sets up the connection; once it has a complete connection, it hands 
# the incoming data stream to the server program

# say you have an SSH server listening on TCP port 22, the operating 
# system knows that port 22 is open and attached to the SSH daemon,
# a request arrives for port 22. The operating system performs the TCP
# three-way handshake. Only where there is a working connection 
# does the kenerl poke the SSH daemon and say, hi this data stream is 
# for you. 

# //// if a client can set up a three-way handshake, but never actually 
# //// connects, it is probably the server program.
# //// if there is no three-way handshake, there operating system didn't
# //// complete the connection

