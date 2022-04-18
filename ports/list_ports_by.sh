#!/usr/bin/env bash

# how can you list all network conns by port n
lsof -i :n
: <<EXAMPLE
lsof -i :80
COMMAND     PID    USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
ld-linux- 17908 weining   18u  IPv4 3655001      0t0  TCP 192-168-1-106.tpgi.com.au:52618->server-13-224-179-99.syd1.r.cloudfront.net:http (CLOSE_WAIT)
java      17918 weining   18u  IPv4 3655001      0t0  TCP 192-168-1-106.tpgi.com.au:52618->server-13-224-179-99.syd1.r.cloudfront.net:http (CLOSE_WAIT)

EXAMPLE
