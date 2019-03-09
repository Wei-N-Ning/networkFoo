#!/usr/bin/env bash

# motivation:
# to emulate cloud firewall

# source:
# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04
# very helpful

# UFW - uncomplicated firewall, an interface to iptables 
# to simplify the configuration. 
# iptables is sold and flexible but can be difficult for beginners

setup_default_policies() {
    # the first rules to define are your defauly policies
    # control how to handle traffic that does not explicitly match 
    # any other rules.
    # no one can connect to it, but application within the server
    # can reach the outside world
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
}

allow_ssh_connections() {
    # equivalent to sudo ufw allow 22
    sudo ufw allow ssh

    # to enable ssh debug port
    sudo ufw allow 2222
}

enable_ufw() {
    # do this after enabling ssh
    sudo ufw enable
}

allow_other_connections() {
    # 80 and 443
    sudo ufw allow http
    sudo ufw allow https
}

specific_port_ranges() {
    # to allow x11 connections, use ports 6000-6007
    sudo ufw allow 6000:6007/tcp
    sudo ufw allow 6000:6007/udp
}

specific_ip_addresses() {
    # from and to
    sudo ufw allow from 203.0.113.4

    sudo ufw allow from 203.0.113.4 to any port 22
    #                               ^^^^^^^^^^^ treated as one param
    
    # use cidr block
    sudo ufw allow from 203.0.113.0/24 to any port 22
}

show_rules_with_number() {
    # useful for deleting rules
    sudo ufw status numbered
}

# https://linuxconfig.org/how-to-configure-firewall-in-ubuntu-18-04
