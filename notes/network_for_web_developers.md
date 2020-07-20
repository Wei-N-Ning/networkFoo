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
**review**

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
**review**

local: means the devices on the same subnet

## subnet

MY NOTE: recall the AWS VPC subnet, CIDR notation
see awsExamples/acloudguru/vpc_basic_concepts

each subnet has 1 network address and 1 broadcast address;

each subnet needs a default gateway;

it means I lose 3 usable addresses;
MY NOTE: this is also covered in Ryan's course
**review** how to see if an ip address is in a range

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
**review**

after this the client may send a GET request

if the min travelling time between client and server is 45ms,
this three-way handshake takes 135ms at least;

### header: sequence number

### header: acknowledgement number

### header: flags

## https: SSL/TLS

requires additional three-way handshake for TLS encryption

(after ACK-ACK)

client sends cert
server receives cert and sends cipher text
client sends cipher finished
server agrees to receive request

## TLS -> HSTS

HSTS: http strict transport security

it remembers that a site is https only

it prevents users from going to `http://` then redirected to `https://`

prevents leaking of session cookies over unsecured wifi (because
one forgot to type the `s`)

## UDP

no 3-way handshake required - no connection (connectionless)

the protocol one implements inside UDP has to deal with
drop packets, out of order packets etc.

## ports

to list all the ports in use: ../ports/ports_in_use
**review**

## fetching a website

need to fetch `https://cu.be`

TCP does not know what `cu.be` is, it needs an IP address

it looks up through DNS

opens a socket

connects to the IP address on port 443 (https)

send HTTPS request over the connection

get data back, get images, css, js over the same connection

close the connection

show the webpage

### DNS lookups

two types:

- authoritative: in charge of the domain name
- recursive: asks the authoritative server then caches for a while
(cache time is defined by TTL , time to live)

usually you will use a recurisve server owned by your internet provider

client wants the ip of cu.be
it asks its ISP's **recursive DNS server**,
this one asks the **Root DNS server** for what is .be - there are 13 of them worldwide
it gets the **.be DNS server** address
it asks for cu.be
the .be DNS server replies with the **cu.be DNS server** address
it asks for cu.be
it gets the answer
it replies the client
**review**

sometime DNS request takes a little time

### DNS lookup records

the actual lookups depend on the types of DNS record:

- A record: pointer to IPv4 address
- AAAA record: pointer to IPv6 address
- CNAME: aliases for A record
- MX: mail servers
- NS: DNS servers
- TXT: various stuff, anti-spam mostly

**review**: recall google SRE book (2016) P/224 introduces a DNS-level
load balancing "the simplest solution is to return multiple A or
AAAA records and let the client pick an IP addr arbitrarily"

**review**: two useful tools for DNS lookup

### DNS fallback

each domain has (and should have) at least 2 DNS servers

order is not important (round robin)

DNS is UDP based (port 53)

- no ack
- timeout after x secs
- tries other DNS server(s)
- can also work on TCP but less often used
**review**

## sockets

the layer between your application and protocol: TCP, UDP,
so that you don't have to write the protocol

abstraction; makes it easy to switch between protocols

provide an easy interface

- no need to know impl details
- send a stream of data - split up in packets
- receives lots of data - converted from packets to string

## practices

use timeouts for all:

- fopen
- curl
- SOAP

logging means early detection

## network simulation tools

wanem

linux: iptables
`iptables -A INPUT -m statistic --mode random --probability 0.1 -j DROP`
`iptables -A OUTPUT -m statistic --mode random -probability 0-.1 -j DROP`
