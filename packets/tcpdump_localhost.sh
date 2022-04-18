#!/usr/bin/env bash

# a simple example showing how to intercept the packets on
# localhost (lo) interface, port 8080

# related question:
# https://github.com/trimstray/test-your-sysadmin-skills

# launch an http server
python -m http.server 8080

# test this server
curl localhost:8080

# start tcpdump with sudo
sudo tcpdump -nei lo -Q in host localhost and port 8080

# now, curl the server and and observe the packets
