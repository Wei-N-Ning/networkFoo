#!/usr/bin/env bash

# this shows how to create a single-shot TCP or UDP proxy
# using netcat

# question source:
# https://github.com/trimstray/test-your-sysadmin-skills

# Note: this is not possible with GNU's nc (DA-dell ubuntu 18)
# there is a fun way of using nc as a "ssh server"

#  There is no -c or -e option in this netcat, but you still can execute a command after
#  connection being established by redirecting file descriptors. Be cautious here because
#  opening a port and let anyone connected execute arbitrary command on your site is DAN‐
#  GEROUS. If you really need to do this, here is an example:

#  On ‘server’ side:

#        $ rm -f /tmp/f; mkfifo /tmp/f
#        $ cat /tmp/f | /bin/sh -i 2>&1 | nc -l 127.0.0.1 1234 > /tmp/f

#  On ‘client’ side:

#        $ nc host.example.com 1234
#        $ (shell prompt from host.example.com)

#  By doing this, you create a fifo at /tmp/f and make nc listen at port 1234 of address
#  127.0.0.1 on ‘server’ side, when a ‘client’ establishes a connection successfully to
#  that port, /bin/sh gets executed on ‘server’ side and the shell prompt is given to
#  ‘client’ side.


tcp_proxy() {
    nc -l -p 2000 -c "nc localhost 3000"
}

udp_proxy() {
    nc -l -u -p 2000 -c "nc -u localhost 3000"
}

tcp_to_udp() {
    nc -l -p 2000 -c "nc -u localhost 3000"
}

udp_to_tcp() {
    nc -l -u -p 2000 -c "nc localhost 3000"
}
