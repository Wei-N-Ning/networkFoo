#!/usr/bin/env bash

# source
# networking for system admin L2119

connect_to_http_server() {
    # 21:19:50.821118 IP 127.0.0.1.56041 > 127.0.0.1.9000: Flags [S], seq 3191237133, win 65535, options [mss 16344,nop,wscale 6,nop,nop,TS val 1273888630 ecr 0,sackOK,eol], length 0
    # 21:19:50.821177 IP 127.0.0.1.9000 > 127.0.0.1.56041: Flags [S.], seq 1206454651, ack 3191237134, win 65535, options [mss 16344,nop,wscale 6,nop,nop,TS val 1273888630 ecr 1273888630,sackOK,eol], length 0
    # 21:19:50.821190 IP 127.0.0.1.56041 > 127.0.0.1.9000: Flags [.], ack 1, win 6379, options [nop,nop,TS val 1273888630 ecr 1273888630], length 0

    # if client establishes a TCP connection, you will get a 
    # blank line 
    # netcat hasn't sent any application data but it has 
    # performed the three way handshake (as shown above S->S.->.)
    
    # server
    python -m http.server 9000
    # client
    nc -v localhost 9000
    # monitor
    tcpdump -ni lo0 ip

    # use the HTTP verbs:
    # found 0 associations
    # found 1 connections:
    #      1:	flags=82<CONNECTED,PREFERRED>
    # 	outif en0
    # 	src 10.0.1.67 port 61680
    # 	dst 172.217.25.46 port 80
    # 	rank info not available
    # 	TCP aux info available

    # Connection to google.com port 80 [tcp/http] succeeded!
    # GET / HTTP/1.1
    # host:google.com
    GET / HTTP/1.1
    host: www.google.com
    # double enter 

}


