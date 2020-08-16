#!/usr/bin/env bash

# how to allow traffic to or from specific ip addresses?

# question source:
# https://github.com/trimstray/test-your-sysadmin-skills

allow_addresses() {
    /sbin/iptables -A INPUT -p tcp -s XXX.XXX.XXX.XXX -j ACCEPT
    /sbin/iptables -A OUTPUT -p tcp -d  XXX.XXX.XXX.XXX -j ACCEPT
}

block_addresses() {
    :
    # source:
    # https://www.cyberciti.biz/faq/how-do-i-block-an-ip-on-my-linux-server/
    iptables -A INPUT -s IP-ADDRESS -j DROP
}
