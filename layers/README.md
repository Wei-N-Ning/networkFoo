# Network Layers

source: networking for systems admins, L207

a better source: Network programming with Go P11-12,
see **how an HTTP request travels from layer 7 on the client to layer 7 on the server**

## the most important things about layers

source: <https://github.com/trimstray/test-your-sysadmin-skills#simple-questions>

The most important things to understand about the OSI (or any
other) model are:

we can divide up the protocols into layers

layers provide encapsulation

layers provide abstraction

layers decouple functions from others

## layers

they are divided into several logical layers for convenience
and simplicity. Each layer handles a very specific task
and usually interacts only with the layers immediately
above and below it

when a (network) layer breaks, it **takes all the layers above
with it.** Diagnosing a network problem requires first
identifying the lowest layer that has a problem.

a trouble ticket that says, here's the diagnostic output that shows
a layer3 problem, but layer2 works fine, will get a much better response.

the layered network model is often called a network stack or the TCP/IP stack.

academic: OSI 7 layer model

modern networks: TCP/IP model

## the simplified version: 5 layers

----
#### Why there are two layered representations?

network programming with go

the TCP/IP model simplifies OSI's presentation

this simplification exists because researchers developer prototype impl first and then
formally standardized their final implementation, resulting in a model geared toward
practical use.

on the other hand, committees spent considerable time dvising the OSI reference model
to address a wide range of requirements before anyone created an impl, leading to the
model's increased complexity

----

to understand the modern internet-attached network you need only 5 layers:

- application (7)
- *presentation (6)
- *session (5)
- transport (4)
- network (3)
- datalink (2)
- physical (1)

(5: session layer - TLS, SOCKS,
6: presentation layer - serialization, translation)

## layer 1

the physical layer traditional has no intelligence, the datalink
layer determines how it is used.

the unit of data here is `bit`

## layer 2

the datalink layer transforms the networks' upper layers into the
signals transmitted over the wire; **a single lump of datalink data
is called a frame.**

NOTE:

ethernet belongs to this layer
see: <https://en.wikipedia.org/wiki/Ethernet>
Ethernet provides services up to and including the data link layer.

MAC address: Media Access Control address
IPv4: MAC, ARP
IPv4: MAC, ND

the loopback interface does not have an underlying layer 2
as it is a pure software interface.

## layer 3

layer 3 (network) maps connectivity between hosts.
this is where the system answers question: how do I get to this
other host? can I get to this other host?

the network layer provides a consistent interface to network
programs, so they can use the network over any physical and
datalink layers.

A single chunk of network data is called a **packet**.

the internet uses the internet protocol (IP) -> the IP in TCP/IP;

## layer 4

layer 4 transport, **a piece of transport layer data is a segment.**

3 most common transport layer protocols:

ICMP (internet control message proto, e.g. the `ping` command);

TCP (transmission control proto), user datagram proto (UDP)

UDP etc.

## layer 5 - 6

the next 3 layers are session, presentation and application.

the session layer: opening, using an closing transport layer
connections.

the presentation layer lets progs exchange data with on another,

the TCP/IP model calls everything above the transport layer the application layer,
including protocols: HTTP, SMTP, LDAP

## layer in action

L270
your browser takes your request, gets the ip address for the site
and asks the operating system for a connection to that IP address
on TCP port 80

the transport layer in the operating system kernel takes
the request and slices it into chunks small enough to fit
inside TCP segments (536 bytes or smaller). It hands these
segments down to the network layer.

the network layer only cares about where that segment needs to go.
If the network layer knows how to reach the destination address,
it wraps each segment with IP information to create a packet and hands
the packet off to the datalink layer.

the datalink layer doesn't know about IP addresses, let alone browsers.
It only knows how to launch packets at a particular MAC address
at the other end of a piece of wire.

The datalink layer adds information for the physical protocol to
the packet, creating a frame and sends it across the wire.

the wire carries the frame to the dest, where the target computer
peel off the layers, reassembles the request, and hands it
upt to the web server.

The web server processes the request and returns a response, which
takes the same journey back.

## router's role

one of the jobs of a router is to strip a frame's datalink
information for one physical layer and add the datalink for a
new physical layer before sending on the packet

## layer and tools

L280

1 (phy) link light, ipconfig/ifconfig, cable replacement
2 (dl) arp, ND, tcpdump
3 (nt) ping, traceroute
4 (tp) netstat, netcat, tcpdump
5+ logs, debuggers

narrow down the problem: the server has a link light on this
connection but I'm not getting an ARP reply from the gateway.

## troubleshooting layer 1

phy layer offers two troubleshooting interface:

interface commands and link lights.

(disconnected on Windows)

ifconfig: display link status

ethtool (linux only):

always chop a failed cable in half before discarding it.

## troubleshooting layer 2

arp: lists the other ethernet addresses that your operating
system sees on the network.

arp tables only shows ethernet address that should appear on your
configured IP address range

use tcpdump to see what traffic the host receives from the
network

## troubleshooting layer 3

when the network layer fails your host cannot deliver packets
to hosts beyond the local subnet; use ping and `traceroute`.

## troubleshooting layer 4

netstat to view established connections;

netcat: to see if you can transmit data to another host

tcpdump: see if data arrives at your server and verify your host
is actually sending data

## Ethernet

L343

ehternet is a broadcast protocol.... either your network core,
the server's network card or the card's device driver
separates out data intended for your system from the data
meant for other systems.

### a broadcast domain, LAN

a section of ethernet where all the hosts can communicate directly with
each other without involving a route, is called a broadcast domain,
a segment, or a local area network (LAN)

### mac address

every device on an ethernet needs a unique identifier, called a
MAC address (48 bit long), or ethernet address.

the first six numbers of the MAC address identifies the ethernet
card manufacturer

## speed and duplex

L364

duplex: how each end handles transmitting and receiving data.

An interface running at half duplex can either receive or transmit
data at any instance but not both.

For a connection to work well, both sides must agree on
speed and duplex. (it won't work if server speaks 1Gbps,
but the switch insists on 100Mbps)

if they disagree on duplex, the connection might appear to
work but will lose frames under load.

modern equipment auto-negotiates connection speed and duplex,
agreeing on the fastest settings both sides support.

the protocol speed effectively says both sides speak the same
language, but not how fast each side can actually exchange
traffic.

## datalink layer frame

what happens when a packet is too large for the datalink layer's
frame: it fragments that data into pieces it can manage.

when the data reachs the destination, the dest system
reassembles those fragments into a complete unit.
fragmentation increases load on both the server and the client.

### Maximum Transimission Unit

MTU: most systems set a `Maximum Transimission Unit`, the
largest size that can fit through the datalink layer.

older ethernet: 1500 bytes

100Mbs ethernet: 9001 bytes jumbo frames

#### example 1: CA's dev.jump host

observe the MTU value which is 9001

#### example 2: da-dell

see: <https://askubuntu.com/questions/445186/how-to-check-current-mtu-value>

```text
ifconfig | grep -i mtu

docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
vmnet1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
vmnet8: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
wlp59s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
```

## IPv4

L624

to connect a host to a network it needs a valid IP address
and a subnet mask.

if it needs to communicate with hosts beyond the local network,
it needs a default gateway.

knowing the addresses of your DNS servers is a definite
plus

### netmask, CIDR

L654

length in bits: a netmask is the number of fixed bits in the
local network.

A/25 network has 25 fixed bits.

CIDR: classless inter-domain routing

```text
/24 255.255.255.0

# bits # hosts Usable: 2 ^ (32 - 24)
```

hosts netmask Cisco mask

```text
/4 268435456 268435454 240.0.0.0 15.255.255.255
/5 134217728 134217726 248.0.0.0 7.255.255.255
/6 67108864 67108862 252.0.0.0 3.255.255.255
/7 33554432 33554430 254.0.0.0 1.255.255.255
/8 16777216 16777214 255.0.0.0 class A network 0.255.255.255 ****
/9 8388608 8388606 255.128.0.0 0.127.255.255
/10 4194304 4194302 255.192.0.0 0.63.255.255
/11 2097152 2097150 255.224.0.0 0.31.255.255
/12 1048576 1048574 255.240.0.0 0.15.255.255
/13 524288 524286 255.248.0.0 0.7.255.255
/14 262144 262142 255.252.0.0 0.3.255.255
/15 131072 131070 255.254.0.0 0.1.255.255
/16 65536 65534 255.255.0.0 class B network 0.0.255.255 ****
/17 32768 32766 255.255.128.0 0.0.127.255
/18 16384 16382 255.255.192.0 0.0.63.255
/19 8192 8190 255.255.224.0 0.0.31.255
/20 4096 4094 255.255.240.0 0.0.15.255
/21 2048 2046 255.255.248.0 0.0.7.255
/22 1024 1022 255.255.252.0 0.0.3.255
/23 512 510 255.255.254.0 0.0.1.255
/24 256 254 255.255.255.0 class C network 0.0.0.255 ****
/25 128 126 255.255.255.128 0.0.0.127
/26 64 62 255.255.255.192 0.0.0.63
/27 32 30 255.255.255.224 0.0.0.31
/28 16 14 255.255.255.240 0.0.0.15
/29 8 6 255.255.255.248 0.0.0.7
/30 4 2 255.255.255.252 0.0.0.3
/31 point to point links only
/32 1 1 255.255.255.255 single IP address use host notation
```

### localhost and 192.168... address

run `nc -l -u 192.168.0.14 32345` (substitute the ip address to
my actual ip address)

and then run `nc -l -u localhost 32345`

for each experiment, observe the open file list: `lsof -p <pid>`

the first form accepts remote connection;

the second form only accepts local/lo connection;

in comparison, running the perl oneliner UDP server, it
accepts any addresses on the host:

```text
perl5.18 81226 weining 3u IPv4 0x7993effe0b4c8565 0t0 UDP \*:32345
```

therefore it receives text sent to both localhost and the
local subnet address

### private addresses

you can't just grab random addresses for your private network,
your random addresses are probably in use elsewhere on the
internet, and if you use them on your private network you
won't be able to communicate with that remote network.

various internet bodies have set aside three subnets for
use on private networks.

you can not use them on the public internet, but anybody
can use them on a private network.

```text
10.0.0.0/8
172.16.0.0/12
192.168.0.0/16
```

### Network Address Translation: NAT

NAT rewrites packets in flight,
when a host with a private IP addresses sends traffic through
a NAT device, the NAT device rewrites the outbound traffic
so that it appears to be coming from the NAT device device's
public IP address.

When the remote site answers, the NAT device rewrites the
response so that it goes to the original client.

the NAT device maintains a table of connections, and tracks
the state of each connection so that it can properly open
and close connections as needed.

Most home routers are NAT devices.

A firewall is most often some combination of packet filter,
proxy server and NAT.

Proxies, NAT devices and firewalls are not "Internet security
systems". They are components in an organization's security
policy, but the devices on their own are merely points of
policy enforcement.

### Good Readings

The practice of network security monitoring

The tao of network security monitoring

Extrusion detection

## IPv6

L862

ARIN: American Registry for internet numbers

## TCP/IP

L993

the word-segment isn't used very often,
instead you will see references to a UDP or TCP package, which
means an individual segment wrapped in an IP packet.

the IP packet contains vital information, like the source and
destination IP addresses. Think of a segment like a fast-food
hamburger in wax paper. IF a cashier dropped a fresh hot
burger, unwrapped, straight in your hand, you'd consider it
incomplete.

## UDP

UDP is called connectionless because a UDP data "stream"
is not really a stream: it is a whole bunch of independent
packets that just happen to be travelling in the same
direction.

## three way handshake

on connection

- one host requests a connection (TCP packet with SYN flag)
- dest host either accepts, rejects or ignores the req
- if dest accepts, it sends back info on how to connect (SYN ACK)
- when the first host acknowledges the receipt of that info (ACK)
- it can start transmitting data

NOTE: if the server rejects, it also sends back a packet, but this
time it carries the `R` flag (rejected)

four way handshake (on teardown)

L1148

CLOSE_WAIT

TIME_WAIT

FIN_WAIT_2

LAST_ACK

the three way and four way teardown handshake status can show up
in the output of netstat

## sockets

L1107

a socket is a communication endpoint for a process
it is a virtual construction for plugging communication into.

tcp connection state

L1137
