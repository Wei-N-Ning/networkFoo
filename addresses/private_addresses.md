# Private IP (v4) address

source: network programming with go P23

RFC 1918 details that private address spaces of:
`10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16` for us in local networks.

universities, corps, governments and residential networks can use these subnets
for local addressing.

in addition, each host has the `127.0.0.0/8` subnet designated as its local
subnet, addresses in this subnet are local to the host and simply called `localhost`. Even if your computer is not on a network, it should still have
an address on the `127.0.0.0/8` subnet, most likely `127.0.0.1`

