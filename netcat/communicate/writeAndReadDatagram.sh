#!/usr/bin/env bash

# related reading:
# Linux Socket By Example 166 (sendto())

# source:
#
# use Linux Pipe:
# https://www.digitalocean.com/community/tutorials/how-to-use-netcat-to-establish-and-test-tcp-and-udp-connections-on-a-vps
#
# https://stackoverflow.com/questions/2149564/redirecting-tcp-traffic-to-a-unix-domain-socket-under-linux
#
# basic tutorial:
# https://ubidots.com/blog/how-to-simulate-a-tcpudp-client-using-netcat/
#
# set timeout to 0 so that netcat won't wait forever
# https://serverfault.com/questions/498880/nc-netcat-hangs-waiting-for-more-data-in-udp-mode


ADDR_AFLOCAL=/tmp/sut/thereisacow
ADDR=127.0.0.1
PORT=9001

setUp() {
    set -e
    rm -rf /tmp/sut /tmp/_ /tmp/_.* /tmp/__*
    mkdir /tmp/sut
}

do_read_local() {
    nc -l -U ${ADDR_AFLOCAL}
}

# $1:
do_write_local() {
    echo ${1} | nc -U ${ADDR_AFLOCAL}
}

do_read_udp() {
    nc -w 0 -l -u ${ADDR} ${PORT}
}

# $2:
do_write_udp() {
    echo ${1} | nc -w 0 -u ${ADDR} ${PORT}
}

setUp

# failing to call do_read first will result in a connection error:
# nc: unix connect failed: No such file or directory
do_read_local &
sleep 0.1
do_write_local "iddqd idkfa"
wait

# this is a similar "one-shot" example using localhost and UDP;
# note the use of -w 0 to let netcat not blocking
do_read_udp &
sleep 0.1
do_write_udp "set noclip 1"
wait
