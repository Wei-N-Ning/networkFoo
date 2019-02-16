#!/usr/bin/env bash

# related reading:
# Linux Socket By Example 166 (sendto())

# See csockets/tests/chapter6/simpleUDPServer.sh for a
# C implementation, following the example in the book,
# of the same client-server model.

# Note this example is also a good starting point to see the internal 
# activities behind sendto() and recvfrom() (i.e. strace)
# do:
# echo "asd" >${TMPDIR}/dd
# nc -w 0 -l -u 127.0.0.1 9988 &
# nc -w 0 -u 127.0.0.1 9988 <${TMPDIR}/dd

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
# however this still requires the "recipient" address and port to
# be valid, otherwise it blocks
# see
# https://stackoverflow.com/questions/45122231/netcat-will-not-send-messages-through-udp-connection-between-socket-pdu-blocks-i
# https://stackoverflow.com/questions/10250003/how-to-avoid-netcat-from-blocking-when-using-it-as-a-client-to-send-a-file-or-p
# https://stackoverflow.com/questions/11387067/using-netcat-to-send-a-udp-packet-without-binding
# this is pretty neat:
# https://stackoverflow.com/questions/12267905/how-to-send-a-file-using-netcat-and-then-keep-the-connection-alive



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
