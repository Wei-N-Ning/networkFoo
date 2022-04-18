#!/usr/bin/env bash

# source:
# network programming in Go P/39

# the pointer (ptr) record allows you to perform a reverse lookup
# by accepting an IP address and returning its corresponding domain name

# example:
# use `find my IP address` (google it) to find my ip address
# say, 110.174.17.29

dig 29.17.174.110.in-addr.arpa ptr

: <<SRC
; <<>> DiG 9.10.6 <<>> 29.17.174.110.in-addr.arpa ptr
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 39907
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;29.17.174.110.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
29.17.174.110.in-addr.arpa. 172800 IN	PTR	110-174-17-29.static.tpgi.com.au.

;; AUTHORITY SECTION:
17.174.110.in-addr.arpa. 172800	IN	NS	ns2.tpgi.com.au.
17.174.110.in-addr.arpa. 172800	IN	NS	ns1.tpgi.com.au.

;; Query time: 12 msec
;; SERVER: 192.168.1.1#53(192.168.1.1)
;; WHEN: Thu Apr 07 20:06:33 AEST 2022
;; MSG SIZE  rcvd: 137

SRC