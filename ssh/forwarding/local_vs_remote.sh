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

there are two cooperating ssh processes.. you don't distinguish 
between the ssh client and server... inside this session, ssh creates 
multiple channels (or logical streams) for carrying data.
it creates a new channel for each use of a port forwarding

//// the listening side

(A,P) -> (B, W)
once the session is established, the ssh process on A is listening 
for incoming TCP connection requests on port P
tell the application client that its server is on (A,P) instead 
of (B,W) and the stage is now set for port forwarding

when the application client tries to connect to its server, it 
connects instead to the listening ssh process

//// the connecting side 

the ssh listener notices this and accepts the connection, it then 
notifies its partner ssh process that a new instance of this port 
forwarding is starting up, and thery cooperate to establish a new 
channel for carrying the data for this forwarding instance

finally the partner ssh process initiates a TCP connection to the 
target of the port forwarding: the application server listening on 
(B,W)

P/381
in local forwarding, the application client and hence the listening 
side are located with the SSH client. The application server and 
connecting side are located with the SSH server

in a remote forwarding, the situation is reversed: the application 
client and listening side are located with the SSH server, while 
the application server and connecting side are located with the 
SSH client

TEXT



