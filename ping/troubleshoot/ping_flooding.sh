#!/usr/bin/env bash

# how to disable ping due to ping flooding 
temporarily_disable() {
    # must be done by the root user (not even sudo)
    echo 1 >/proc/sys/net/ipv4/icmp_echo_ignore_all
}

permanently_disable() {
    vim /etc/sysctl.conf

    # add 
    net.ipv4.icmp_echo_ignore_all = 1
    # then
    sysctl -p
}
