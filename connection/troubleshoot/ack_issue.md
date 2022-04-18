# three way handshake: delayed ack

what happen when the last **ACK** is not sent;

how to prevent that?

<https://en.wikipedia.org/wiki/TCP_delayed_acknowledgment>

## what happens (on the server) when a client does not respond to the SYN-ACK segment (second step) of the three-way handshake used in TCP

source: <https://networkengineering.stackexchange.com/questions/32504/what-happens-on-the-server-when-a-client-does-not-respond-to-the-syn-ack-segme>

the server will periodically retransmit the syn-ack and eventually
timeout and abandon the connection entry if the final ack is not
received.

This does consume some RAM and is the subject of DoS attacks.
However there are operating system mitigations available - in
linux minisocks are used to keep the footprint down and after a
certain point you can transition to syncookies which don't require
any server side state during this period. (but they have downsides).

## ack flooding attack

source: <https://www.imperva.com/learn/ddos/syn-flood/>

In a SYN flood attack, the attacker sends repeated SYN packets
to every port on the targeted server, often using a fake IP address.

The server, unaware of the attack, receives multiple, apparently
legitimate requests to establish communication. It responds to
each attempt with a SYN-ACK packet from each open port.
