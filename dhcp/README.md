# DHCP

dynamic host configuration protocol

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
