#!/usr/bin/env bash

# SSH definitive 2nd P/377

: <<"TEXT"

ssh -o ClearAllForwardings=yes

openssh provides a solution, the client conf keyword 
ClearAllForwardings.
It nullifies any forwarding specified in the current ssh command,
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
the original tunnel continues to exist but ClearAllForwardings 
prevents the second invocation from attempting to re-create the 
tunnel.
TEXT