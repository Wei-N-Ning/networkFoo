#!/usr/bin/bash 

# source
# https://stackoverflow.com/questions/13669585/how-to-get-a-list-of-all-valid-ip-addresses-in-a-local-network

# sudo apt-get install nmap

# then

scan_ip_range() {
    nmap -sP 192.168.1.*

    # example at CA (calling nmap on u18vbox, which itself is reported in the list)
    # nmap -sP 10.0.3.*
    # Starting Nmap 7.60 ( https://nmap.org ) at 2019-01-14 22:38 UTC
    # Nmap scan report for 10.0.3.26
    # Host is up (0.61s latency).
    # Nmap scan report for 10.0.3.36
    # Host is up (0.27s latency).
    # Nmap scan report for 10.0.3.46
    # ......
    # Host is up (0.21s latency).
    # Nmap scan report for u18vbox (10.0.3.200)
    # Host is up (0.00021s latency).
    # Nmap scan report for 10.0.3.210
    # Host is up (0.66s latency).
    # ......
    # Nmap scan report for 10.0.3.250
    # Host is up (0.16s latency).
    # Nmap scan report for 10.0.3.251
    # Host is up (0.022s latency).
    # Nmap done: 256 IP addresses (37 hosts up) scanned in 31.98 seconds
}

# $1: 192.168.1.*
scan_one() {
    nmap -sP "${1}" | perl -lne "/for\s(has\w+)/ && print \$1"
}
