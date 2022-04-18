#!/usr/bin/env bash

# source
# networking for systems admin, L1064
# the Internet Assigned Numbers Authority (IANA)
# maintains the authoritative list of port assignments
#
# www.iana.org

# $1: port
ports_used_by_services() {
    # see:
    # https://stackoverflow.com/questions/3321829/how-do-i-best-pass-arguments-to-a-perl-one-liner
    local port_number=${1:?"missing port number"}
    perl -slane \
    '@F[1] =~ /^$portnum/ && print $_' \
    -- -portnum=${port_number} \
    /etc/services

    # see also:
    # Why is /etc/services full of email addresses?
    # https://discussions.apple.com/thread/460081

}

ports_listening() {
    # //// not working on mac ////
    # -l: listening
    # -p: show program name (use sudo to see processes owned
    # by root user, such as sshd)
    # tested on CA dev.jump
    sudo netstat -lnp

    lsof -i
    lsof -i:80  # all the processes listening to port 80
    kill -9 $(lsof -t -i:80)  # -t for pids only

    ss -l  # recall ss is a better replacement for netstat
    netstat -atn # tcp
    netstat -aut # udp
    netstat -tulapn # tcp + udp
}


all_ports_in_use() {
    # https://askubuntu.com/questions/538208/how-to-check-opened-closed-ports-on-my-computer
    netstat -atn

    # -a: (--all) display all sockets; -l (--listening) display
    #     listening server sockets
    # -t: (--tcp), -u (--udp)
    # -n: to speed things up without resolve names
    # see: L1181
    # not running reverse DNS lookup on every IP address
    # on a busy server this might mean hundreds or thousands of lookups
    # many hosts have no reverse DNS, so these lookups can take a 
    # quite long time before they fail
    # "I recommend almost always using -n"

    # this works on linux (CA dev.jump, ubuntu) and (CA
    # macbook pro)
    netstat -an
}
