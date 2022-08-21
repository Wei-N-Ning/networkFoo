# DHCP

DHCP is in the application layer

dynamic host configuration protocol - to assign unique IPv4 address to
each host on a private subnet.

a client sends a request to DHCP server;
DHCP servers assign IP addrs to the client, and also:
ip addr, netmast, gateway, DNS servers

each IP is leased from the pool of IP addrs the DHCP server
manages;
the lease expiration time is configurable on the DHCP server
(1hr, 1day, 1week etc.);
the client must renew the lease if it wants to keep using the
IP addr;
if no renewal is received, the IP is available to other DHCP
clients;

## Request (address) configuration information automatically

read: multiplayer game development P/52

upon connecting to the network, the host creates DHCPDISCOVER
message containing its own MAC address and broadcasts it using
UDP to 255.255.255.255:67.

because this goes to every host on the subnet, any DHCP server
present will receive the message. The DHCP server, if it has an
IP address to offer the client, prepares a DHCPOFFER packet.

this packet contains both the offered IP address and the MAC
address of the client to be sent the offer.

at this point the client has no IP address assigned, so the server can't
directly address a packet to it. Instead, the server broadcasts
the packet to the entire subnet on UDP port 68. All DHCP clients
receive the packet,and each checks the MAC address in the message
to determine if **it is the intended recipient**

when the correct client receives the message, it reads the offered
IP address and decides if it would like to accept the offer. If so,
it responds, via broadcast, with a DHCPREQUEST message requesting
the offered address.

If the offer is still available, the server responds, again via
broadcast, with a DHCPACK message.

this message both confirms to the client that the IP address is
assigned, and conveys any additional network info necessary, such
as the subnet mask, router address, and any recommended DNS name
servers to use.
