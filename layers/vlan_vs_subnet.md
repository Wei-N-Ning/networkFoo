# VLAN v.s. Subnet

source: <https://github.com/trimstray/test-your-sysadmin-skills#simple-questions>

VLANs and subnets solve different problems. VLANs work at Layer 2, thereby altering broadcast domains (for instance). Whereas subnets are Layer 3 in the current context.

Subnet - is a range of IP addresses determined by part of an address (often called the network address) and a subnet mask (netmask). For example, if the netmask is 255.255.255.0 (or /24 for short), and the network address is 192.168.10.0, then that defines a range of IP addresses 192.168.10.0 through 192.168.10.255. Shorthand for writing that is 192.168.10.0/24.

VLAN - a good way to think of this is "switch partitioning." Let's say you have an 8 port switch that is VLAN-able. You can assign 4 ports to one VLAN (say VLAN 1) and 4 ports to another VLAN (say VLAN 2). VLAN 1 won't see any of VLAN 2's traffic and vice versa, logically, you now have two separate switches. Normally on a switch, if the switch hasn't seen a MAC address it will "flood" the traffic to all other ports. VLANs prevent this.

Subnet is nothing more than an IP address range of IP addresses that help hosts communicate over layer 2 and 3. Each subnet does not require its own VLAN. VLANs are implemented for isolation (are sandbox for layer two communication, no 2 systems of 2 different VLANs may communicate but it can be done through Inter VLAN routing), ease of management and security.
