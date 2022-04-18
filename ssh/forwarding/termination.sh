#!/usr/bin/env bash

# SSH definitive 2nd P/390

: <<"TEXT"

when happens if you try to terminate an SSH session while it still 
has active forwarded connections
SSH notices and wait for them to disconnect before stopping the 
session

TIME_WAIT problem:
TIME_WAIT state is an artifact of the TCP protocol. In certain 
situations the teardown of a TCP conn can leave one of its socket 
endpoints unusable for a short period of time, usually only a few 
minutes. As a result you can not reuse the port for TCP forwarding 
until the teardown completes.
If you are impatient, choose another port for the time being.

TEXT