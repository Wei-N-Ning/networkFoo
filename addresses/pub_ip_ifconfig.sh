#!/usr/bin/env bash

get_public_ip_address_ifconfig() {
    ifconfig | \
    perl -wnl -E '/^en0/../^[^en0]+:/ and say' | \
    perl -wnl -E '/(\d+\.\d+\.\d+\.\d+)/ and say $1'
}

get_public_ip_address_ifconfig
