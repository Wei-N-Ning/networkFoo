#!/usr/bin/env bash

# SSH definitive 2nd P/393

: <<"TEXT"
you are at home, using laptop H and need access a web server W1 
at work, but your employer's internal network is behind a firewall.

we want to redirect the web server over SSH without fussing with
the URL. Most browsers have just such a feature: a proxy.

we can set the browser's HTTP proxy to our SSH-forwarded port 
localhost:8080; this means it always connects to our forwarded 
port in response to any HTTP URL we provide.

proxying won't resolve links to other secured servers issue.

dynamic forwarding: SOCKS forwarding

ssh -D 1080 wein@192.168.0.6

(h6 virtualbox)

we've switched to port 1080 since that is usual SOCKS ports;
8080 or any other port would do as usual. Note that there is 
no destination socket in either command, just the local port 
to be forwarded; that's because the destination is determined 
dynamically, and can be different for each connection.
We use this solution only if the browser has an option to use 
a SOCKS proxy ( as most do)


TEXT


