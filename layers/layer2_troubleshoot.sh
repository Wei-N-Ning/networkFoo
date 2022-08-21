#!/usr/bin/env bash

# LAN: local area network

# how quickly each response came back
ping_cmd() {
    # example: ping canva.com
    # PING canva.com (104.16.81.22): 56 data bytes
    # 64 bytes from 104.16.81.22: icmp_seq=0 ttl=59 time=28.119 ms
    # 64 bytes from 104.16.81.22: icmp_seq=1 ttl=59 time=33.790 ms
    # 64 bytes from 104.16.81.22: icmp_seq=2 ttl=59 time=33.720 ms
    # 64 bytes from 104.16.81.22: icmp_seq=3 ttl=59 time=34.618 ms
    # 64 bytes from 104.16.81.22: icmp_seq=4 ttl=59 time=27.583 ms
    # 64 bytes from 104.16.81.22: icmp_seq=5 ttl=59 time=34.495 ms
    # 64 bytes from 104.16.81.22: icmp_seq=6 ttl=59 time=27.575 ms
    # 64 bytes from 104.16.81.22: icmp_seq=7 ttl=59 time=27.909 ms
    # 64 bytes from 104.16.81.22: icmp_seq=8 ttl=59 time=27.399 ms
    # 64 bytes from 104.16.81.22: icmp_seq=9 ttl=59 time=33.329 ms
    # 64 bytes from 104.16.81.22: icmp_seq=10 ttl=59 time=28.475 ms
    # 64 bytes from 104.16.81.22: icmp_seq=11 ttl=59 time=34.482 ms
    # 64 bytes from 104.16.81.22: icmp_seq=12 ttl=59 time=34.121 ms
    # 64 bytes from 104.16.81.22: icmp_seq=13 ttl=59 time=33.725 ms
    # 64 bytes from 104.16.81.22: icmp_seq=14 ttl=59 time=34.317 ms
    # ^C
    # --- canva.com ping statistics ---
    # 15 packets transmitted, 15 packets received, 0.0% packet loss
    # round-trip min/avg/max/stddev = 27.399/31.577/34.618/3.075 ms
    
    # example: ping qq.com (from ap-southest-1)
    # notice the packet loss rate
    # PING qq.com (111.161.64.40): 56 data bytes
    # 64 bytes from 111.161.64.40: icmp_seq=0 ttl=47 time=449.533 ms
    # 64 bytes from 111.161.64.40: icmp_seq=1 ttl=47 time=472.255 ms
    # 64 bytes from 111.161.64.40: icmp_seq=2 ttl=47 time=392.690 ms
    # 64 bytes from 111.161.64.40: icmp_seq=3 ttl=47 time=360.776 ms
    # 64 bytes from 111.161.64.40: icmp_seq=4 ttl=47 time=405.143 ms
    # 64 bytes from 111.161.64.40: icmp_seq=5 ttl=47 time=451.270 ms
    # 64 bytes from 111.161.64.40: icmp_seq=6 ttl=47 time=470.177 ms
    # 64 bytes from 111.161.64.40: icmp_seq=7 ttl=47 time=356.237 ms
    # 64 bytes from 111.161.64.40: icmp_seq=8 ttl=47 time=359.466 ms
    # 64 bytes from 111.161.64.40: icmp_seq=9 ttl=47 time=430.034 ms
    # 64 bytes from 111.161.64.40: icmp_seq=10 ttl=47 time=448.699 ms
    # 64 bytes from 111.161.64.40: icmp_seq=11 ttl=47 time=469.553 ms
    # 64 bytes from 111.161.64.40: icmp_seq=12 ttl=47 time=387.097 ms
    # 64 bytes from 111.161.64.40: icmp_seq=13 ttl=47 time=409.882 ms
    # Request timeout for icmp_seq 14
    # 64 bytes from 111.161.64.40: icmp_seq=15 ttl=47 time=448.459 ms
    # 64 bytes from 111.161.64.40: icmp_seq=16 ttl=47 time=473.068 ms
    # 64 bytes from 111.161.64.40: icmp_seq=17 ttl=47 time=361.561 ms
    # 64 bytes from 111.161.64.40: icmp_seq=18 ttl=47 time=408.198 ms
    # 64 bytes from 111.161.64.40: icmp_seq=19 ttl=47 time=427.097 ms
    # 64 bytes from 111.161.64.40: icmp_seq=20 ttl=47 time=445.793 ms
    # 64 bytes from 111.161.64.40: icmp_seq=21 ttl=47 time=464.931 ms
    # 64 bytes from 111.161.64.40: icmp_seq=22 ttl=47 time=483.880 ms
    # ^C
    # --- qq.com ping statistics ---
    # 23 packets transmitted, 22 packets received, 4.3% packet loss
    # round-trip min/avg/max/stddev = 356.237/426.173/483.880/41.024 ms
    :
}

# Address Resolution Protocol
# ARP maps ethernet address (MAC) to IPv4 addresses and back
# is the "glue" (or bridge) that attaches the network layer to the datalink
# layer (calling it a protocol can be confusing...)
# 
# a host that needs to transmit data to another host on the 
# local ethernet first broadcasts an ethernet request, 
# asking which MAC address is responsible for this IP addr,
# the broadcasts got to all hosts attached to that 
# ethernet network (hence term "broadcast domain")
# a host that receives a request for an IP it owns shouts..
# when the original host gets this response, it adds the IP
# and MAC address to its ARP table. The original host 
# can then send the dest traffic.
#
# also the one that responds to the ARP query (ARP query packet)
# will add the caller's IP address to its ARP table, even though
# it might not need the caller's info right now.
arp_cmd() {
    # view ARP table
    # if the system sees many hosts on the local ethernet,
    # you can assume that the local network is up and working
    arp -a
    # ? (192.168.0.1) at 84:1b:5e:46:dc:40 on en0 ifscope [ethernet]
    # ? (192.168.0.6) at a4:e9:75:2d:6b:5c on en0 ifscope [ethernet]
    # ? (192.168.0.14) at f0:18:98:1c:c4:86 on en0 ifscope permanent [ethernet]
    #                                                      ^^^^^^^^^localhost 
    # ? (224.0.0.251) at 1:0:5e:0:0:fb on en0 ifscope permanent [ethernet]
    # ? (239.255.255.250) at 1:0:5e:7f:ff:fa on en0 ifscope permanent [ethernet]

    # if the remote host does not anwser ping, you can not 
    # assume that the host is unreachable. All you know from
    # the ping test is that this host isn't responding to 
    # a layer 3 (network) request. It tells you nothing about
    # the datalink or physical layers
    # even if a host doesn't answer pings, it will answer 
    # the ARP request for that IP address

    # running on CA's dev.jump host
    # arp -a
    # ip-10-0-0-84.ec2.internal (10.0.0.84) at 02:a5:40:a8:c5:3c [ether] on ens5
    # ip-10-0-0-127.ec2.internal (10.0.0.127) at 02:88:8b:1a:f7:e4 [ether] on ens5
    # ip-10-0-0-6.ec2.internal (10.0.0.6) at 02:a6:03:5b:12:38 [ether] on ens5
    # ip-10-0-0-90.ec2.internal (10.0.0.90) at 02:0f:4b:0a:45:4c [ether] on ens5
    # ip-10-0-0-2.ec2.internal (10.0.0.2) at 02:29:0b:d9:d9:3c [ether] on ens5
    # ip-10-0-0-1.ec2.internal (10.0.0.1) at 02:29:0b:d9:d9:3c [ether] on ens5
}

# name discovery
ND() {
    # similar to arp, map MAC addresses to IPv6 addresses
    # linux: 
    ip -6 neigh show
    # NOTE:
    # tested in CA dev.jump host, it didn't show nothing

    # tested on da-dell:
    # ip -6 neigh show
    # fe80::1e3b:f3ff:fee3:fd92 dev wlp59s0 lladdr 1c:3b:f3:e3:fd:92 router STALE
}

VLAN() {
    # virtual LANS
    # is an extra tag on ethernet frames indicating that 
    # they belong on a different LAN than  the default
    # ethernet frames that arrive at your network card

    # without this tag belong in the default LAN 

    # these tags let you put multiple VLANS on a single
    # physical wire
    # an interface like eth0:1 on linux
    :
}

datalink_errors() {
    # the error ocunts on both unix and windows systems
    # are totals since the system booted

    # if you see an error count, that does not mean that the
    # system is currently having errors

    # when you see errors on an interface, determine if thay
    # are increasing or constant
    
    # NOTE:
    # one linux I can use watch command
    # on mac I need to brew install watch
    
    # on CA dev.jump host
    netstat -i
    watch -n 1 netstat -i
    # Kernel Interface table
    # Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR Flg
    # ens5       9001 0   5095970      0      0 0       4479171      0      0      0 BMRU
    # lo        65536 0        34      0      0 0            34      0      0      0 LRU

    # on CA macbook pro
    netstat -i
    # Name  Mtu   Network       Address            Ipkts Ierrs    Opkts Oerrs  Coll
    # lo0   16384 <Link#1>                        556738     0   556738     0     0
    # lo0   16384 127           localhost         556738     -   556738     -     -
    # lo0   16384 localhost   ::1                 556738     -   556738     -     -
    # lo0   16384 fe80::1%lo0 fe80:1::1           556738     -   556738     -     -
    # gif0* 1280  <Link#2>                             0     0        0     0     0
    # stf0* 1280  <Link#3>                             0     0        0     0     0
    # VHC12 0     <Link#4>                             0     0        0     0     0
    # XHC20 0     <Link#5>                             0     0        0     0     0
    # XHC1* 0     <Link#6>                             0     0        0     0     0
    # XHC0* 0     <Link#7>                             0     0        0     0     0
    # ap1*  1500  <Link#9>    f2:18:98:1c:c4:86        0     0        0     0     0
    # en0   1500  <Link#10>   f0:18:98:1c:c4:86 52570808     0 24576742 20133     0
    # en0   1500  bfg9000.loc fe80:a::1c32:30fb 52570808     - 24576742     -     -
    # en0   1500  192.168.0     192.168.0.14    52570808     - 24576742     -     -
    # p2p0  2304  <Link#11>   02:18:98:1c:c4:86        0     0        0     0     0
    # awdl0 1484  <Link#12>   3e:d2:af:01:95:e6    87436     0    22969     0     0
    # awdl0 1484  bfg9000.loc fe80:c::3cd2:afff    87436     -    22969     -     -
    # en1   1500  <Link#13>   06:00:90:d2:27:01        0     0        0     0     0
    # en2   1500  <Link#14>   06:00:90:d2:27:00        0     0        0     0     0
    # en3   1500  <Link#15>   06:00:90:d2:27:05        0     0        0     0     0
    # en4   1500  <Link#16>   06:00:90:d2:27:04        0     0        0     0     0
    # bridg 1500  <Link#17>   06:00:90:d2:27:01        0     0        1     0     0
    # utun0 2000  <Link#18>                            0     0        2     0     0
    # utun0 2000  fe80::725c: fe80:12::725c:881        0     -        2     -     -
    # utun1 1380  <Link#19>                         5632     0     6583     0     0
    # utun1 1380  fe80::d9ef: fe80:13::d9ef:d85     5632     -     6583     -     -
    # utun2 1380  <Link#20>                         9182     0    10139     0     0
    # utun2 1380  fe80::b894: fe80:14::b894:492     9182     -    10139     -     -
    # en5   1500  <Link#8>    ac:de:48:00:11:22    23944     0    18041  3963     0
    # en5   1500  fe80::aede: fe80:8::aede:48ff    23944     -    18041     -     -
    :
}


