#!/usr/bin/env bash

# SSH definitive 2nd P/382
# for convenicen, TCP implementations allow programs to make 
# connections between two sockets on the same host
# the connection data is simply transferred from one process 
# to another without actually being transmitted on any real
# network interface

# naked tcp connections are insecure

: <<"TEXT"
the listening side of a forwarding has no access control, so intruders
may again access to it

(lo0) loopback interface: software construct, not corresponding to any 
network hardware; it appears and responds like a real interface 

lo0 leads back to the host itself. A datagram "transmitted" on the 
loopback interface immediately appears as an incoming packet on 
the loopback interface and is picked up and processed by IP

P/384
unless otherwise specified, when asked to listen on a particular 
port, TCP binds all the hosts' interfaces and accepts connections
on any of them

to address it (the world can use your forwarding), ssh by default 
binds only the loopback address for the listening side.
this means that only other programs on the same host may connect 
to the forwarded socket.

this is still not safe on multi-user host

GatewayPorts (-g) allow off-host connections to your forwarded 
ports ... to have the listening side bind all interfaces.

BE AWARE OF THE SECURITY IMPLICATIONS

TEXT




