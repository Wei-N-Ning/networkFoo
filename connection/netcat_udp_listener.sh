#!/usr/bin/env bash

udp_tunnel() {
    # server
    nc -ul 32345

    # client
    nc -u 0.0.0.0 32345
    # type type type

}



