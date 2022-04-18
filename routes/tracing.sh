#!/usr/bin/env bash

# source
# networking for system admins, L2277

# traceroute lets you follow packets as they travel between 
# hosts, viewing what hosts they pass through to reach
# their destination.

# traceroute macgnw.com
# traceroute to macgnw.com (52.95.133.125), 64 hops max, 52 byte packets
#  1  10.0.0.1 (10.0.0.1)  8.204 ms  3.917 ms  5.545 ms
#  2  192.168.100.1 (192.168.100.1)  16.933 ms  11.047 ms  17.057 ms
#  3  125-253-41-46.dyn.ver.bigair.net.au (125.253.41.46)  7.543 ms  22.502 ms  18.754 ms
#  4  203.132.77.133 (203.132.77.133)  7.739 ms  43.541 ms  34.137 ms
#  5  fortygige0-0-1-3.bdr01-ipt-4edenpar-syd.au.superloop.com (103.200.13.98)  14.491 ms  20.595 ms  15.165 ms
#  6  as16509.nsw.ix.asn.au (218.100.52.9)  22.464 ms  9.124 ms  21.308 ms
#  7  52.95.36.16 (52.95.36.16)  45.455 ms
#     52.95.36.80 (52.95.36.80)  22.159 ms  18.659 ms
#  8  52.95.36.125 (52.95.36.125)  21.672 ms
#     52.95.36.141 (52.95.36.141)  10.134 ms
#     52.95.36.125 (52.95.36.125)  26.155 ms
#  9  54.240.192.235 (54.240.192.235)  11.413 ms  23.997 ms
#     54.240.192.111 (54.240.192.111)  11.601 ms
# 10  * * *
# 11  * * *
# 12  * * *
# 13  * * *
# 14  s3-website-ap-southeast-2.amazonaws.com (52.95.133.125)  10.906 ms  19.369 ms  8.366 ms

# each line is a separate host (router or router-like device
# such as firewall)
# the number at the start of the line is the hop number
# you will then get three timestamps, one for each packet sent 
# to that hop
# where a single packet might get lost, sending three packets
# gives a good chance of something getting through,
# the timestamp is how long it takes for a pcket to reach
# that hop and return
# it's a round-trip time, not a one-way trip.

# * indicates a lost packet,
# either the request did not reach the device, this device 
# did not respond to this packet, or the response did not 
# make it back to the client

# traceroute canva.com
# traceroute: Warning: canva.com has multiple addresses; using 104.16.79.22
# traceroute to canva.com (104.16.79.22), 64 hops max, 52 byte packets
#  1  10.0.0.1 (10.0.0.1)  6.277 ms  3.752 ms  5.623 ms
#  2  192.168.100.1 (192.168.100.1)  7.285 ms  19.497 ms  7.033 ms
#  3  125-253-41-46.dyn.ver.bigair.net.au (125.253.41.46)  12.946 ms  15.302 ms  20.683 ms
#  4  203.132.77.133 (203.132.77.133)  9.410 ms  14.014 ms  19.687 ms
#  5  13335.syd.equinix.com (45.127.172.154)  9.142 ms  20.910 ms  21.636 ms
#  6  104.16.79.22 (104.16.79.22)  8.812 ms  33.206 ms  21.675 ms




