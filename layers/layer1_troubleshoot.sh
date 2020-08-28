#!/usr/bin/env bash

# source:
# networking for system admin, L302
unix_tool() {
    # en0 is the interface name
    # check ifconfig's media line and see an interface's 
    # negotiated speed and duplex.
    ifconfig en0  

    # en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	# ether f0:18:98:1c:c4:86
	# inet6 fe80::1c32:30fb:c224:3a84%en0 prefixlen 64 secured scopeid 0xa
	# inet 192.168.0.14 netmask 0xffffff00 broadcast 192.168.0.255
	# nd6 options=201<PERFORMNUD,DAD>
	# media: autoselect
    # ^^^^^
	# status: active

    # check whether a wire or wireless device shows up
    lspci -v
    
}

linux_tool() {
    ethtool en0

: <<EXAMPLE
# on da-dell

sudo ethtool wlp59s0
Settings for wlp59s0:
        Link detected: yes
EXAMPLE
}


