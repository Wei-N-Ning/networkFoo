#!/usr/bin/env bash

# source
# networking for system admin L1795

identify_interfaces() {
    tcpdump -D 
}

specify_interface() {
    tcpdump -n -i eth0

    # -n to turn off dns lookup!
}

read_udp_packets() {
    # 23:10:42.517422 IP 192.168.0.14.51905 > 239.255.255.250.ssdp: UDP, length 174
    # timestamp       IP packet (mine) port   (other host)  
    :
}

read_tcp_packets() {
    # the presence of flags tells you this is a tcp packet
    # flags tell the state of the tcp connection
    # S: syn packet, this is part of the initial three way handshake
    #    either from the client or from the server
    # .: period, ACK, acknowledgement - this packet contains 
    #    info acknowledging other packets
    # R: reset, forcibly terminated; if no connect exists yet
    #    this translates to connection refused; if this happen
    #    during a connection, it means something wrong happens
    # F: in a FIN packat, four way teardown handshake (gracefully)
    # U: urgent
    # W, E: congestion control
    # P: push

    # 10:04:23.885745 IP syd09s14-in-f14.1e100.net.http > 10.58.233.5.55313: 
    #   time stamp           source addr and port            next host and port
    # Flags [S.], seq 2586358747, ack 4279257323, win 60192, 
    # options [mss 1352,sackOK,TS val 3832339732 ecr 1255665970,nop,wscale 8], length 0
    # 
    #
    :
}

# motivation:
# read L1878 for the case study
# when server rejects a connection (404) it put flag R in the packet
# observe:
read_tcp_packats_server_reject() {
    python3 -m http.server 9000
    # observe:
    tcpdump -i lo0 
    # mock client call
    curl localhost:9000/bad

    # the output contains:
    # 10:29:05.096738 IP6 localhost.55387 > localhost.cslistener: Flags [S], seq 4013308495, win 65535, options [mss 16324,nop,wscale 6,nop,nop,TS val 1257146174 ecr 0,sackOK,eol], length 0
    # 10:29:05.096801 IP6 localhost.cslistener > localhost.55387: Flags [R.], seq 0, ack 4013308496, win 0, length 0

    # this verifies:
    # the server receives the packet (request)
    # the server rejects it for some reason

    # the book's example is different in that, the server proc
    # does not run at all, therefore if following the book's 
    # example, the output should look like:
    # 10:34:10.210605 IP6 localhost.55417 > localhost.cslistener: Flags [S], seq 2178083046, win 65535, options [mss 16324,nop,wscale 6,nop,nop,TS val 1257451020 ecr 0,sackOK,eol], length 0
    # 10:34:10.210647 IP6 localhost.cslistener > localhost.55417: Flags [R.], seq 0, ack 2178083047, win 0, length 0
    # 
    # in this case
    # the server receives the packet (request)
    # the server rejects it because nothing can handle it (no server process)
    # things to investigate:
    # - anything listening to the port (9000 in this case)?
    # - the server process is running (with good health)?
    # - server side packet filter?
}

read_address_resolution_records() {
    # tcpdump watch interface en0, then call "host google.com"

    # these run at datalink layer, below TCP/IP
    # L1933
    # if you have multiple IP networks on your ethernet broadcast 
    # domain, tcpdump display the activities from all of them
    
    # "I'm seeing the ARP traffic on my dev box from prod network 
    # but I can not see the dev network"

    # 14:28:37.244891 ARP, Request who-has 10.58.233.5 tell 10.128.128.128, length 46
    #                      not packet but ARP frame
    # 14:28:37.244966 ARP, Reply 10.58.233.5 is-at 88:e9:fe:71:ef:5c (oui Unknown), length 28
    :
}

filter_tcp_traffic_only() {
    # -n: no dns lookup
    # -i en0: interface selection
    # tcp: choose proto (similarly: arp ... )
    tcp -ni en0 tcp

    # better to use "ip"
    # tcp -ni en0 ip host xxx or yyy
}
