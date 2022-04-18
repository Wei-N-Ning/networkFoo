#!/usr/bin/env bash

network_classes_anatomy() {
    : <<"EXAMPLE"
class 
 A      255.0.0.0
 B      255.255.0.0
 C      255.255.255.0

 255 255 0  0
 183 194 46 31
 network address
        host address
EXAMPLE

    # these are referred to as non-routable IPs; not connected
    # to the public network
}

# is a special logical address that is used to send data to
# all the hosts in a given network
# in addition to its own address, all the hosts receive the
# data sent to the broadcast address
broadcast_address() {
    : <<"EXAMPLE"
network     subnet mask       brd address
17.0.0.0     255.0.0.0        17.255.255.255
...
199.83.131.0 255.255.255.0    199.83.131.255
EXAMPLE

}

subnet_cidr_anatomy() {
    # class less interdomain routing
    # allow network to be subdivided regardless of their
    # traditional class
    # the sub-ranges are called subnets
    :
}
