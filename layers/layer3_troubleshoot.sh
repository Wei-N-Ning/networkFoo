#!/usr/bin/env bash

: <<"NOTES"
Networking for system admin L699

router: a device that sends traffic from one IP subnet 
to another. 
if a host needs to get to a system that is not on the 
local network, it sends the packets to the default gateway, 
that's generally the router on the local network.
traditionally the router is either the first or last 
usable address in a subnet, but it does not have to.

Normally the main router sends an ICMP redirect message 
when the client tries to reach a host behind a secondary 
router, telling the client to go to the secondary router 
for that host. The client automatically sends all 
traffic for that destination address to the proper router.

hosts can only communicate directly with hosts on the same 
IP subnet. If a host is on a different IP subnet, it 
sends all traffic through the router. It doesn't matter 
if the two servers are on the same phy ethernet; if they 
are on different IP subnets, all traffic goes through
the router. IP knows nothing about ethernet.
NOTES

display_routing_table() {
    netstat -nr

    # on CA dev.jump host (ubuntu)
    # Kernel IP routing table
    # Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
    # 0.0.0.0         10.0.0.1        0.0.0.0         UG        0 0          0 ens5
    # 10.0.0.0        0.0.0.0         255.255.255.0   U         0 0          0 ens5
    # 
    # the first entry is our default route, pointing to the 
    # gateway at 10.0.0.1; the second entry is the route for
    # the local network.


    # on CA macbook pro
# Routing tables

# Internet:
# Destination        Gateway            Flags        Refs      Use   Netif Expire
# default            192.168.0.1        UGSc           58        0     en0
# 127                127.0.0.1          UCS             0        0     lo0
# 127.0.0.1          127.0.0.1          UH              1    39468     lo0
# 169.254            link#10            UCS             0        0     en0
# 192.168.0          link#10            UCS             1        0     en0
# 192.168.0.1/32     link#10            UCS             2        0     en0
# 192.168.0.1        84:1b:5e:46:dc:40  UHLWIir        12       60     en0   1157
# 192.168.0.6        a4:e9:75:2d:6b:5c  UHLWIi          3       74     en0    351
# 192.168.0.14/32    link#10            UCS             0        0     en0
# 224.0.0/4          link#10            UmCS            2        0     en0
# 224.0.0.251        1:0:5e:0:0:fb      UHmLWI          0        0     en0
# 239.255.255.250    1:0:5e:7f:ff:fa    UHmLWI          0       29     en0
# 255.255.255.255/32 link#10            UCS             0        0     en0

# Internet6:
# Destination                             Gateway                         Flags         Netif Expire
# default                                 fe80::%utun0                    UGcI          utun0
# default                                 fe80::%utun1                    UGcI          utun1
# default                                 fe80::%utun2                    UGcI          utun2
# ::1                                     ::1                             UHL             lo0
# fe80::%lo0/64                           fe80::1%lo0                     UcI             lo0
# fe80::1%lo0                             link#1                          UHLI            lo0
# fe80::%en5/64                           link#8                          UCI             en5
# fe80::aede:48ff:fe00:1122%en5           ac:de:48:0:11:22                UHLI            lo0
# fe80::aede:48ff:fe33:4455%en5           ac:de:48:33:44:55               UHLWIi          en5
# fe80::%en0/64                           link#10                         UCI             en0
# fe80::8ce:2e2b:e087:261a%en0            a4:e9:75:2d:6b:5c               UHLWIi          en0
# fe80::1c32:30fb:c224:3a84%en0           f0:18:98:1c:c4:86               UHLI            lo0
# fe80::%awdl0/64                         link#12                         UCI           awdl0
# fe80::3cd2:afff:fe01:95e6%awdl0         3e:d2:af:1:95:e6                UHLI            lo0
# fe80::%utun0/64                         fe80::725c:8813:f27c:e117%utun0 UcI           utun0
# fe80::725c:8813:f27c:e117%utun0         link#18                         UHLI            lo0
# fe80::%utun1/64                         fe80::d9ef:d854:74f4:f832%utun1 UcI           utun1
# fe80::d9ef:d854:74f4:f832%utun1         link#19                         UHLI            lo0
# fe80::%utun2/64                         fe80::b894:492c:211:39bb%utun2  UcI           utun2
# fe80::b894:492c:211:39bb%utun2          link#20                         UHLI            lo0
# ff01::%lo0/32                           ::1                             UmCI            lo0
# ff01::%en5/32                           link#8                          UmCI            en5
# ff01::%en0/32                           link#10                         UmCI            en0
# ff01::%awdl0/32                         link#12                         UmCI          awdl0
# ff01::%utun0/32                         fe80::725c:8813:f27c:e117%utun0 UmCI          utun0
# ff01::%utun1/32                         fe80::d9ef:d854:74f4:f832%utun1 UmCI          utun1
# ff01::%utun2/32                         fe80::b894:492c:211:39bb%utun2  UmCI          utun2
# ff02::%lo0/32                           ::1                             UmCI            lo0
# ff02::%en5/32                           link#8                          UmCI            en5
# ff02::%en0/32                           link#10                         UmCI            en0
# ff02::%awdl0/32                         link#12                         UmCI          awdl0
# ff02::%utun0/32                         fe80::725c:8813:f27c:e117%utun0 UmCI          utun0
# ff02::%utun1/32                         fe80::d9ef:d854:74f4:f832%utun1 UmCI          utun1
# ff02::%utun2/32                         fe80::b894:492c:211:39bb%utun2  UmCI          utun2


}


