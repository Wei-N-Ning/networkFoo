# Gateway

in the corporate world, companies commonly require all outgoing
connections to pass through a proxy server or `gateway` host:
a machine connected to both the company network and the outside.

Although connected to both networks, a gateway host doesn't act
as a router and the networks remain separated. Rather it allows
limited, application level access between two networks.

- recall aws internet gateway (igw)

## subnets and indirect routing

source: multiplayer game programming P/29

```text
host A1 (18.19.100.2)  host A2 (18.19.100.3)  host A3 (18.19.100.4)
       \                    |                     /
        \                   |                    /
         \                  |                   /
         host R
         NIC 0 (18.19.100.1)
         NIC 1 (18.19.200.1)
         /                  |                   \
        /                   |                    \
       /                    |                     \
host B1 (18.19.200.2)  host B2 (18.19.200.3)  host B3 (18.19.200.4)   
```

### Host A1 routing table

|row|Dest Subnet   |Gateway     | NIC |
|---|-----------   |---         | --- |
|1  |18.19.100.0/24|            | NIC 0 (18.19.100.2) |
|2  |18.19.200.0/24|18.19.100.1 | NIC 0 (18.19.100.2) |

### Host B2 routing table

|row|Dest Subnet   |Gateway     | NIC |
|---|-----------   |---         | --- |
|1  |18.19.200.0/24|            | NIC 0 (18.19.200.2) |
|2  |18.19.100.0/24|18.19.200.1 | NIC 0 (18.19.200.2) |

### Host R routing table

|row|Dest Subnet   |Gateway     | NIC |
|---|-----------   |---         | --- |
|1  |18.19.100.0/24|            | NIC 0 (18.19.100.1) |
|2  |18.19.200.0/24|            | NIC 1 (18.19.200.1) |

### When host A1 attempts to send a packet to host B1

(1) host A1 builds an IP packet with source address 18.19.100.2 and
dest address 18.19.200.2

(2) host A1's IP module runs through the rows of its routing table
from top to bottom, until it finds the first one with a dest subnet
that contains the IP address 18.19.200.2 - in this case, that is row
number 2. Note that the order of the rows is **significant**, as
multiple rows might match a given address

(3) the gateway listed in row 2 is 18.19.100.1, so host A1 uses
ARP and its Ethernet module to wrap the packet in an Ethernet
frame and send it to the MAC address that matches IP address
18.19.100.1 - this packet arrives at host R

(4) host R's Ethernet module, running for its NIC 0 with IP
address 18.19.100.1 receives the packet, detects the payload
is an IP packet, and passes it up to its IP module

(5) host R's IP module sees the packet is addressed to 18.19.200.2,
so it attempts to forward the packet to 18.19.200.2

(6) host R's IP module runs through its routing table until it finds
a row whose dest subnet contains 18.19.200.2 - in this case it is row
number 2

(7) row number 2 has no gateway, which means the subnet is directly
routable. However the NIC column specifies the use of the NIC 1
with IP address 18.19.200.1 - this is the NIC connected to
network Bravo

(8) host R's IP module passes the packet to the Ethernet module
running for host R's NIC 1. It uses ARP and the Ethernet module
to wrap the packet in an Ethernet frame and send it to the MAC
address that matches IP 18.19.200.2

(9) host B1's Ethernet module receives the packet, detects the
payload is an IP packet, and passes it up to its IP module

(10) host B1's IP module sees that the dest IP address is its own.
It sends the payload up to the next layer for more processing
