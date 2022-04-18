#!/usr/bin/env bash

establish_conn() {
    nc -uv google.com 80
    # found 0 associations
    # found 1 connections:
    #      1:	flags=82<CONNECTED,PREFERRED>
    # 	outif (null)
    # 	src 10.0.1.67 port 54449
    # 	dst 216.58.203.110 port 80
    # 	rank info not available

    # Connection to google.com port 80 [udp/http] succeeded!
}




