#!/usr/bin/env bash

# SSH definitive 2nd P/377

: <<"TEXT"
if you use LocalForward or RemoteForward in your configuration file...
the conf works fine if you connect ONCE

but if you try to open a second ssh connection to the same host at the 
same time - perhaps to run a different program in another window 
of your workstation, the attempt fails:

Local: bind: address already in use

because your configuraton file section tries to forward port again 
but finds that port is already in use by the first instance of ssh

you need some way to make the connection but omit the port forwarding

# 
ssh -o ClearAllForwardings=yes

openssh provides a solution, the client conf keyword 
ClearAllForwardings.
It nullifies any forwarding specified in the current ssh command,
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
the original tunnel continues to exist but ClearAllForwardings 
prevents the second invocation from attempting to re-create the 
tunnel.
TEXT