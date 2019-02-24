#!/usr/bin/env bash

# networking for system admin, L1054
# logical ports
# TCP and UDP both use logical ports to multiplex connections
# between machines, permitting one host to serve many different
# services to many hosts 
# when a network service like a web server starts, it attaches
# or binds to one or more logical ports 
# a logical port is a number between 0 and 65535
# TCP and UDP logical ports are separate things although they 
# use the same ranges of port numbers

# L1075
# say you call up a web page, your desktop might pick port 
# 50000 as a source port. It sends a request to port 80 on 
# the web server. The server accepts the connection, and 
# sends its response back to port 5000 on the client, using 
# port 80 as the source port. 
# port 80 on the server's IP address and port 50000 on the 
# client's IP address now represent a single connection.

# this unique combination of ports and IP addresses permits
# multiplexing of connections.
# a client that wants to make 10 separate connections to a 
# web site can, so long as it uses 10 different source ports

# combining source and destination IP addresses with separate 
# source and dest ports creates a unique id for each conn

# ephemeral port range

# L1085
# the standard way to show IPv6 address/port combination
# is to put the addr in square brackets
# if you want to put an IPv6 address and port in your 
# browser you must include the brackets

inspect_protocols() {
    cat /etc/protocols 
}




