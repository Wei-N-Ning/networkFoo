#!/usr/bin/env bash

# ping uses icmp (there is NO PORT NUMBER!!)

ping 1.0.0.1

# 0 0 can be omitted
ping 1.1

# ping only once
ping -c1 1.1

# rtt: round trip time
# ping does not have priority, therefore tcp with real traffic
# can be faster

# inspect icmp interface using tcpdump
# ping www.google.com 
# NOTE:
# to listen on a particular interface, use -i <interface>
# sudo tcpdump -n icmp -i lo

: <<EXAMPLE
sudo tcpdump -n icmp

tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on wlp59s0, link-type EN10MB (Ethernet), capture size 262144 bytes

# request
17:42:56.398462 IP 192.168.1.106 > 216.58.196.132: ICMP echo request, id 25737, seq 1, length 64

# response
17:42:56.406846 IP 216.58.196.132 > 192.168.1.106: ICMP echo reply, id 25737, seq 1, length 64

17:42:57.397970 IP 192.168.1.106 > 216.58.196.132: ICMP echo request, id 25737, seq 2, length 64
17:42:57.406690 IP 216.58.196.132 > 192.168.1.106: ICMP echo reply, id 25737, seq 2, length 64
17:42:58.399771 IP 192.168.1.106 > 216.58.196.132: ICMP echo request, id 25737, seq 3, length 64
17:42:58.413087 IP 216.58.196.132 > 192.168.1.106: ICMP echo reply, id 25737, seq 3, length 64
17:42:59.401188 IP 192.168.1.106 > 216.58.196.132: ICMP echo request, id 25737, seq 4, length 64
17:42:59.409665 IP 216.58.196.132 > 192.168.1.106: ICMP echo reply, id 25737, seq 4, length 64
17:43:00.402774 IP 192.168.1.106 > 216.58.196.132: ICMP echo request, id 25737, seq 5, length 64
17:43:00.411165 IP 216.58.196.132 > 192.168.1.106: ICMP echo reply, id 25737, seq 5, length 64
17:43:01.404253 IP 192.168.1.106 > 216.58.196.132: ICMP echo request, id 25737, seq 6, length 64
17:43:01.412726 IP 216.58.196.132 > 192.168.1.106: ICMP echo reply, id 25737, seq 6, length 64
17:43:02.405785 IP 192.168.1.106 > 216.58.196.132: ICMP echo request, id 25737, seq 7, length 64
17:43:02.414449 IP 216.58.196.132 > 192.168.1.106: ICMP echo reply, id 25737, seq 7, length 64
17:43:03.406840 IP 192.168.1.106 > 216.58.196.132: ICMP echo request, id 25737, seq 8, length 64
17:43:03.415239 IP 216.58.196.132 > 192.168.1.106: ICMP echo reply, id 25737, seq 8, length 64
^C
16 packets captured
16 packets received by filter
0 packets dropped by kernel

EXAMPLE
