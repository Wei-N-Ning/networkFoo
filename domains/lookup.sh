#!/usr/bin/env bash

function digForIP() {
    dig -x "107.170.4.117"
}

function hostForIP() {
    host "107.170.4.117"

    # example: 
    # running on u18 vm (10.0.3.200 being its ip)
    # host 10.0.3.200
    # 200.3.0.10.in-addr.arpa domain name pointer u18vbox.
    # 200.3.0.10.in-addr.arpa domain name pointer u18vbox.local.
}

digForIP
hostForIP

: '
two useful tools: dig and nslookup
show the complete listing of what is present on the DNS

example:

dig www.baidu.com

; <<>> DiG 9.11.3-1ubuntu1.12-Ubuntu <<>> www.baidu.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 42317
;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;www.baidu.com.			IN	A

;; ANSWER SECTION:
www.baidu.com.		1034	IN	CNAME	www.a.shifen.com.
www.a.shifen.com.	62	IN	CNAME	www.wshifen.com.
www.wshifen.com.	260	IN	A	119.63.197.139
www.wshifen.com.	260	IN	A	119.63.197.151

;; Query time: 8 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Mon Jul 20 12:37:29 AEST 2020
;; MSG SIZE  rcvd: 127

nslookup www.baidu.com

Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
www.baidu.com	canonical name = www.a.shifen.com.
www.a.shifen.com	canonical name = www.wshifen.com.
Name:	www.wshifen.com
Address: 119.63.197.139
Name:	www.wshifen.com
Address: 119.63.197.151

'