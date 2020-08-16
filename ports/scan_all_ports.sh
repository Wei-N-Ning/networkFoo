#!/usr/bin/env bash

# -n: no DNS look up ('cos the IP is known)
# 1-1000: slower than nmap
# -z: perform a scan, but not attempting to connect
# 2>&1:
# the messages returned are sent to stderr, hence the
# redirection

netcat() {
    nc -z -n -v 127.0.0.1 1-1000 2>&1 | perl -lne \
        '/Connection to(.*)succeeded/ && print $1'
}

# question source:
# https://github.com/trimstray/test-your-sysadmin-skills
nmap() {
    # source: 
    # https://phoenixnap.com/kb/nmap-command-linux-examples
    
    nmap localhost
    nmap subdomain.server.com

    : <<EXAMPLE
nmap localhost

Starting Nmap 7.80 ( https://nmap.org ) at 2020-08-16 15:51 AEST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000056s latency).
Not shown: 996 closed ports
PORT    STATE SERVICE
22/tcp  open  ssh
443/tcp open  https
631/tcp open  ipp
902/tcp open  iss-realsecure

Nmap done: 1 IP address (1 host up) scanned in 0.10 seconds
EXAMPLE
}
