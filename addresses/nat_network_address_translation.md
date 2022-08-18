# NAT: Network address translation

NAT is in the application layer. (recall AWS NAT gateway)

Read: multiplayer game development P/53

luckily it is possible to connect an entire subnet of hosts to
the internet through a single shared public IP address

this is made possible by network address translation or NAT

to configure a network for NAT, each host on the network must be
assigned a privately routable IP address

## Private IP Address blocks

IANA has reserved these private IP address blocks for private use,
guaranteeing that no address from those blocks will ever be assigned
as a public IP address. Thus any user may set up their own private
network using privately routable IP addresses without checking for
uniqueness.

it doesn't matter if multiple private networks employ the same private
IP addresses internally.

|IP address Range              | Subnet                    | Num Addresses |
|-----------------             |--------                   | -----         |
|10.0.0.0 - 10.255.255.255     | 10.0.0.0/8                | 16777216      |
|172.16.0.0 - 172.31.255.255   | 172.16.0.0/12             | 1048576       |
|192.168.0.0 - 192.168.255.255 | 192.168.0.0/16            | 65536         |

## WAN NIC and LAN NIC

P/54

### LAN

because the privately addressed NIC is connected to the local network,
it is called local area network, LAN, port

### WAN

because the publically addressable NIC is connected worldwide,
it is called wide area network, WAN, port
