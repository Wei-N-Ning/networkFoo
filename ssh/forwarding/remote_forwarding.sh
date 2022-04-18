#!/usr/bin/env bash

# SSH definitive 2nd P/376

: <<"TEXT"
a remotely forwarded port is just like a local one, but the directions 
are reversed
this time the TCP client is remote, its server is local, and a 
              ^^^^^^^^^^^^^^^^^^^        ^^^^^^^^^^^^^^
forward connection is initiated from the remote machine

suppose you are logged into server machine S, where the IMAP server 
is running. You can now create a secure tunnel for remote clients 
to reach the IMAP server on port 143. You select a random port number 
to forward (2001) and create the tunnel

ssh -R 2001:localhost:143 H

ssh can now forward connections from (localhost,143) to (H,2001)
once this command has run, a secure tunnel has been constructed 
from the port 2001 on the remote machine H, to port 143 on the srv 
machine S. Now any program on H can use the secure tunnel by connecting 
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
to (localhost,2001)
^^^^^^^^^^^^^^^^^^^

TEXT

remote_forwarding_h7_to_h6() {
    # h7 has an http server, serving on 8080
    # h7 remote-forward to h6 
    ssh -N -R 9080:localhost:8080 wein@192.168.0.6
    
    # assuming no firewall is turned on
    # h6 can visit the server in two ways:
    #          forwarded
    diff <(curl localhost:9080) <(curl 192.168.0.7:8080)

    # keyword in client conf:
    RemoteForward 9080 192.168.0.6:8080

    # gateway port in remote forwarding
    # OpenSSH server does accept GatewayPorts option
    # and it applies globally to all remote forwardings
    # established by that server
    # this allows the server admin to control whether 
    # users can bind to nonlocal sockets
    
    # without this server option, one can not visit the http
    # server via h6
    # NOP
    curl 192.168.0.6:9080 
}


