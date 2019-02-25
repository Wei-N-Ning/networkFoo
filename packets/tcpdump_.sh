#!/usr/bin/env bash

# source
# networking for system admin L1795

identify_interfaces() {
    tcpdump -D 
}

specify_interface() {
    tcpdump -n -i eth0

    # -n to turn off dns lookup!
}

read_udp_packets() {
    # 23:10:42.517422 IP 192.168.0.14.51905 > 239.255.255.250.ssdp: UDP, length 174
    # timestamp       IP packet (mine) port   (other host)  
}