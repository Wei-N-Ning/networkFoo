# Network for Web Developers

source: youtube

## OSI model

layer 7 application (we build):
http, dns, smtp

layer 6 presentation:
serialization, data translation

layer 5 session (blury):
TLS, L2TP, SOCKS, PPTP

layer 4 transport:
tcp, udp, ports

layer 3 network:
ip addressing, ipv4, ipv6

layer 2 data link:
data protocol is mostly **ethernet**

layer 1 physical:
wires, network card, wireless interface

## Basics, packats

0101 -> physical cable or wireless -> 0101

bits of data are grouped in packets;

packets always consist of

- header
- contents

packets contain other packets:

```text
packet type 1 header (eg. ethernet packet)
packet type 1 contents
    packet type 2 header (eg. ipv4 packet)
    packet type 2 contents
        packet type 3...  (eg. tcp/ip packet)
```

packet-transition includes pack and unpack these packets

## history of network devices

hub:
work on layer 1;
all connected devices can send at the same time,
causing collision (which causes retransmit);
low throughput (10mbps)

switch:
next phrase (mid 90s);
each network device has a MAC addr
(assigned by manufactor + can be overwritten in vm);
if two devices are connected to the switch, they are on the same phyiscal network;
they comm by sending ethernet packets with dest MAC addr
**switch knows which device (and port) has each MAC addr**

## sending IP traffic on local network

need to know the MAC address - use ARP, address resolution
protocol - for lookup.
UPDATE: see ../addresses/check_arp_entries

local: means the devices on the same subnet

## subnet

MY NOTE: recall the AWS VPC subnet, CIDR notation
see awsExamples/acloudguru/vpc_basic_concepts

each subnet has 1 network address and 1 broadcast address;

each subnet needs a default gateway;

it means I lose 3 usable addresses;
MY NOTE: this is also covered in Ryan's course

## how do ip packets find their way - routing

each layer 3 network node has a routing table

## TCP/IP packet

lots of stuffs in the header!

### three-way handshake

when a client tries to establish TCP connection to a server,
it sends a TCP packet with SYN flag
sequence number = 1000 (or some random number)
if server accepts it, it sends back a packet with SYN ACK flag,
sequence number is incremented,
acknowledge number is set
client replies with ACK flag ("I acknowledge that you have acknowledged")
increments both sequence number and acknowledge number

after this the client may send a GET request

if the min travelling time between client and server is 45ms,
this three-way handshake takes 135ms at least;

### header: sequence number

### header: acknowledgement number

### header: flags
