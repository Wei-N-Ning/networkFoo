#!/usr/bin/env bash

# SSH definitive 2nd P/378

: <<"TEXT"
If the tcp client application (whose connections you want to forward)
is running locally on the SSH client machine, use local forwarding;
otherwise the client application is on the remote SSH server machine,
and you use remote forwarding

use a local forwarding when the application client is on the local
side of the SSH connection;
and a remote forwarding when it is on the remote side

the listening side

the connecting side

P/381
in local forwarding, the application client and hence the listening 
side are located with the SSH client. The application server and 
connecting side are located with the SSH server

in a remote forwarding, the situation is reversed: the application 
client and listening side are located with the SSH server, while 
the application server and connecting side are located with the 
SSH client

TEXT



