# The Berkeley Sockets API

read: multiplayer game development P/66

## the socket function

```c++
SOCKET socket(int af, int type, int protocol);
```

### address family

af: address family; indicates the network layer protocol

AF_UNSPEC: unspecified

AF_INET: IPv4

AF_IPX: internet packet exchange - an early network layer protocol
popularized by Novell and MS-DOS

AF_APPLETALK: an early network suite popularized by apple computer
for use with its Apple and Macintosh Computers

AF_INET6: IPv6

### type

the type parameter indicates the meaning of packets sent and received
through the socket.

each transport layer protocol that the socket can use has a corresponding
way in which it groups and uses packets

SOCK_STREAM: (TCP) packets represent segments of an ordered, reliable stream of data

SOCK_DGRAM: (UDP) packets represent discrete datagrams

SOCK_RAW: packet headers may be custom crafted by the application layer

SOCK_SEQPACKET: similar to SOCK_STREAM but packets may need to be read in their entirety upon receipt

### Protocol

IPPROTO_UDP, IPPROTO_TCP
