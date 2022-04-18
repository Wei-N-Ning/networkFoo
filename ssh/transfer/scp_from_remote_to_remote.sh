#!/usr/bin/env bash

# read this
# https://askubuntu.com/questions/153960/scp-with-two-different-ports
# You can use ~/.ssh/config to specify the ports to use for the hosts (and for setting many other nice things; check the man page man ssh_config):

# ~/.ssh/config

# Host 67.12.21.133
#   Port 6774

# Host 67.129.242.40
#   Port 6774

# in the same post someone mentions -P, but it does not work in
# ubuntu 17+
# https://linuxacademy.com/blog/linux/ssh-and-scp-howto-tips-tricks/#specifying-a-port-with-scp
# 