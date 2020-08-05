#!/usr/bin/env bash

show_process_sockets() {
    # ss: another utility to inspect sockets
    # ss is used to dump socket statistics. It allows showing 
    # information similar to netstat.  It can display more TCP 
    # and state informations than other tools.

    # -t: tcp
    # -p: show process

    # works on centos 7 and u18
    # note the peer's address and port - in this example it is a macbook pro
    # that making the ssh connection (note how it chose a random port)
    # the local port says "ssh" - recall ssh/config Port
    # State   Recv-Q   Send-Q   Local   Address:Port   Peer   Address:Port
    # ESTAB   0         0       10.0.3.252:ssh         10.0.1.67:54047
    ss -tp
}

showProcessTCP

