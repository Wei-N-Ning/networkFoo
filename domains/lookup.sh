#!/usr/bin/env bash

function digForIP() {
    dig -x "107.170.4.117"
}

function hostForIP() {
    host "107.170.4.117"

    # example: 
    # running on u18 vm (10.0.3.200 being its ip)
    # host 10.0.3.200
    # 200.3.0.10.in-addr.arpa domain name pointer u18vbox.
    # 200.3.0.10.in-addr.arpa domain name pointer u18vbox.local.
}

digForIP
hostForIP
