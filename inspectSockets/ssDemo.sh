#!/usr/bin/env bash

function showProcessTCP() {
    # works on centos 7 and u18
    # note the peer's address and port - in this example it is a macbook pro
    # that making the ssh connection (note how it chose a random port)
    # the local port says "ssh" - recall ssh/config Port
    # State   Recv-Q   Send-Q   Local   Address:Port   Peer   Address:Port
    # ESTAB   0         0       10.0.3.252:ssh         10.0.1.67:54047
    ss -tp
}

showProcessTCP

