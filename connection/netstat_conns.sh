#!/usr/bin/env bash

# motivation
# observe connection using netstat

get_dest_public_address() {
    # recap in SSH definitive 2nd, P/389
    # netstat -a -n should all the network connections and listeners
    # on that machine

    # run CA's 
    infra ssh dev.jump 
    # then 
    netstat -an | grep -i .22
    # the result shows:
    netstat -an | grep .22
    # tcp4       0      0  192.168.0.14.51168     18.213.29.236.22       ESTABLISHED

    # the public address of CA's dev.jump host is 
    ssh wei@18.213.29.236

    # further experiment:
    # run aws ssm start-session --target... on CA macbook pro
    # and watch the netstat output with "watch"
    # recall that AWS SSM talks to remote via port 443 
    watch -n 0.5 "netstat -an | grep .443"
    # the caller (macbook pro) sends some bytes to remote 52.94.233.129
    # on port 443
    # Recv Send
    # 0   1029  192.168.0.14.51228     52.94.233.129.443      ESTABLISHED

}

show_only_tcp_connections() {
    # unix variant
    # tested on mac (-p protocol)
    netstat -na -p tcp
    # show only established connections
    netstat -np tcp
    # show only listening sockets
    netstat -ln4

    # tested on ubuntu linux (-t for tcp-only)
    netstat -nat

    # networking for system admin, L1338
    # show prog, tcp, listening only, ip address
    netstat -ptln 

}

show_prog_listening_on_port() {
    # tested on both ubuntu (CA dev.jump) and macbook pro
    # -i: see all network ports in use (need sudo to 
    #     see the privileged processes)
    # -n: no DNS reverse resolution
    sudo lsof -n -i
}




