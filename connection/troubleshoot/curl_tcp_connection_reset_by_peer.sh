#!/usr/bin/env bash

# question source: 
# https://github.com/trimstray/test-your-sysadmin-skills

: <<TEXT

    check if the URL is correct, maybe you should add www or set correctly Host: header? Check also scheme (http or https)
    check the domain is resolving into a correct IP address
    enable debug tracing with --trace-ascii curl.dump. Recv failure is a really generic error so its hard for more info
    use external proxy with --proxy for debug connection from external ip
    use network sniffer (e.g. tcpdump) for debug connection in the lower TCP/IP layers
    check firewall rules on the production environment and on the exit point of your network, also check your NAT rules
    check MTU size of packets traveling over your network
    check SSL version with ssl/tls curl params if you connecting to https protocol
    it may be a problem on the client side e.g. the netfilter drop or limit connections from your IP address to the domain

TEXT
