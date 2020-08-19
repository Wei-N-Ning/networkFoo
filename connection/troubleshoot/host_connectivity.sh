#!/usr/bin/env bash
# --------------------------------------
# can not connect to a host, what to do?
# --------------------------------------

ping_host() {
    # recall ping does not use a port; it uses the ICMP protocol
    ping '<host>'
    ping -c 1 '<host>'

    # if ping works with ip addr but not hostname, there is
    # something wrong with the DNS
    ping -c 3 '<host ip address>'

    : <<"EXAMPLE"
localize the problem:

ping local host ---- x ---- ping google.com
local conf                  google is down
               router, isp

EXAMPLE
}

