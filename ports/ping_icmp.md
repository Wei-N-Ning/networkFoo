# ping and ICMP

ping uses ICMP, specifically ICMP echo request and ICMP echo reply packets. There is no 'port' associated with ICMP. Ports are associated with the two IP transport layer protocols, TCP and UDP. ICMP, TCP, and UDP are "siblings"; they are not based on each other, but are three separate protocols that run on top of IP.

ICMP packets are identified by the 'protocol' field in the IP datagram header. ICMP does not use either UDP or TCP communications services, it uses raw IP communications services. This means that the ICMP message is carried directly in an IP datagram data field. raw comes from how this is implemented in software, to create and send an ICMP message, one opens a raw socket, builds a buffer containing the ICMP message, and then writes the buffer containing the message to the raw socket.

The IP protocol value for ICMP is 1. The protocol field is part of the IP header and identifies what is in the data portion of the IP datagram.
