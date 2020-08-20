# Ports

source: <https://en.wikipedia.org/wiki/Port_(computer_networking)>

In computer networking, a port is a communication endpoint.
At the software level, within an operating system, a port is a
logical construct that identifies a specific process or a type of
network service.

"Put it simply, it is how we address the service, like we address
a building or a office room"

## ranges

1-65535

1-1023: system ports

```text
privilege ports
22
25 smtp
80 http
143 imap
389 ldap
443 https
```

## Command Ports

SERVICE PORT
SMTP 25
FTP 20 for data transfer and 21 for connection established
DNS 53
DHCP 67/UDP for DHCP server, 68/UDP for DHCP client
SSH 22
