#!/usr/bin/bash 

# source
# https://stackoverflow.com/questions/13669585/how-to-get-a-list-of-all-valid-ip-addresses-in-a-local-network

# sudo apt-get install nmap

# then

nmap -sP 192.168.1.*

# $1: 192.168.1.*
scan_one() {
    nmap -sP "${1}" | perl -lne "/for\s(has\w+)/ && print \$1"
}
