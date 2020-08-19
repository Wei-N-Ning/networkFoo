#!/usr/bin/env bash

# server is not responding

# is payload being delivered at all?
check_payload_delivered() {
    # -A display ASCII text to capture any human-readable
    # contents in the payload (such as url)
    sudo tcpdump -n -A -v
    # pay attention to the source ip addr
}
