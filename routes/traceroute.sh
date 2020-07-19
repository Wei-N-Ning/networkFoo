#!/usr/bin/env bash

# sends a series of test packets to experimentally determine
# the current route to a host

# this is performed by incrasing the IP protocol time to live (TTL)
# by one for each packet, causing the sequence of gateways
# to the host to reveal themselves by sending ICMP time
# exceeded response messages

# the path taken can be also studied as part of static perf
# tuning.

