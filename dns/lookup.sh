#!/usr/bin/env bash

# source:
# https://www.2daygeek.com/check-find-dns-records-of-domain-in-linux-terminal/

dig '<www.google.co.nz>'
nslookup '<www.google.co.nz>'

resolve_hostname() {
    dig google.com ANY +noall +answer
    : <<"EXAMPLE"
; <<>> DiG 9.11.3-1ubuntu1.12-Ubuntu <<>> google.com ANY +noall +answer
;; global options: +cmd
google.com.		69	IN	A	172.217.25.174
google.com.		292	IN	AAAA	2404:6800:4006:807::200e
google.com.		3600	IN	TXT	"v=spf1 include:_spf.google.com ~all"
google.com.		300	IN	TXT	"docusign=1b0a6754-49b1-4db5-8540-d2c12664b289"
google.com.		3600	IN	TXT	"facebook-domain-verification=22rm551cu4k0ab0bxsw536tlds4h95"
google.com.		3600	IN	TXT	"globalsign-smime-dv=CDYX+XFHUw2wml6/Gb8+59BsH31KzUr6c1l2BPvqKX8="
google.com.		300	IN	TXT	"docusign=05958488-4752-4ef2-95eb-aa7ba8a3bd0e"
google.com.		70708	IN	CAA	0 issue "pki.goog"
google.com.		600	IN	MX	20 alt1.aspmx.l.google.com.
google.com.		600	IN	MX	50 alt4.aspmx.l.google.com.
google.com.		600	IN	MX	10 aspmx.l.google.com.
google.com.		600	IN	MX	30 alt2.aspmx.l.google.com.
google.com.		600	IN	MX	40 alt3.aspmx.l.google.com.
google.com.		97729	IN	NS	ns2.google.com.
google.com.		97729	IN	NS	ns1.google.com.
google.com.		97729	IN	NS	ns4.google.com.
google.com.		97729	IN	NS	ns3.google.com.
google.com.		34	IN	SOA	ns1.google.com. dns-admin.google.com. 327400874 900 900 1800 60

EXAMPLE
}

resolve_ip_to_hostname() {
    dig -x 172.217.25.174
    : <<"EXAMPLE"
; <<>> DiG 9.11.3-1ubuntu1.12-Ubuntu <<>> -x 172.217.25.174
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49178
;; flags: qr rd ra; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;174.25.217.172.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
174.25.217.172.in-addr.arpa. 11455 IN	PTR	sin01s16-in-f14.1e100.net.
174.25.217.172.in-addr.arpa. 11455 IN	PTR	syd09s13-in-f174.1e100.net.
174.25.217.172.in-addr.arpa. 11455 IN	PTR	syd09s13-in-f14.1e100.net.

;; Query time: 9 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Thu Aug 20 15:26:03 AEST 2020
;; MSG SIZE  rcvd: 156
EXAMPLE

}

resolve_hostname_to_hostname() {
    dig www.qq.com +noall +answer
    : <<"EXAMPLE"
; <<>> DiG 9.11.3-1ubuntu1.12-Ubuntu <<>> www.qq.com +noall +answer
;; global options: +cmd
www.qq.com.		161	IN	CNAME	news.qq.com.edgekey.net.
news.qq.com.edgekey.net. 1590	IN	CNAME	e6156.dscf.akamaiedge.net.
e6156.dscf.akamaiedge.net. 19	IN	A	104.95.98.109
EXAMPLE

}