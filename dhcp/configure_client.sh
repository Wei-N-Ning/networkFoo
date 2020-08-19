#!/usr/bin/env bash

# find the network device:
ip link

# edit /etc/network/interfaces
: <<"EXAMPLE"
# interfaces(5) file used by ifup(8) and ifdown(8)
auto lo
iface lo inet loopback

EXAMPLE