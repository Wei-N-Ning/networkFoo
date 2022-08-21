# Port and Transport Layer

Read: multiplayer game development P/40

> ... because multiple processes can be running on a single host,
it's not always enough to know that Host A sent an IP packet to
Host B: When Host B receives the IP packet, it needs to know which
process should be passed the contents for further processing.
> to solve this, the transport layer introduces the concept of
ports.
> using a transport layer module, a process can bind to a specific
port, telling the transport layer module that it would like to be
passed any communication addressed to that port
