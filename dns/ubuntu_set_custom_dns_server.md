# Manually Config DNS Server on Ubuntu 18/20

source:

<https://www.ricmedia.com/set-custom-dns-servers-on-ubuntu-18-or-20/>

## Motivation

why i want to do that?

because the automatically configured DNS server (provided by the ISP)
didn't work, symptom:

this times out:

```shell
dig jfrog-prod-use1-shared-virginia-main.s3.amazonaws.com
```

but with google's DNS server, it works

```shell
dig jfrog-prod-use1-shared-virginia-main.s3.amazonaws.com @8.8.8.8
```

### how to find google's DNS server address

for both IPv4 and IPv6

read: <https://developers.google.com/speed/public-dns/docs/using>

## Configuration

I need to configure this for both wired network and wireless (WIFI) network,

but it is only doable when either the wired network or the wireless one
is in use! (i.e. I have to plug in the cable in order to configure
the wired settings)

Follow the article. I just to switch DNS configuration to manual and
correctly type in the google DNS addresses:

```text
ipv4, ipv4

ipv6, ipv6
```

### IMPORTANT: must restart the connection

I must restart the connect (wired or wireless) so that the change
will take effect !!

### IMPORTANT: how to verify the DNS setting

run `systemd-resolve --status`, and I should see these at the
bottom page (keep paging down)

```text
... (a lot of texts)

Link 3 (wlp2s0)
      Current Scopes: DNS
DefaultRoute setting: yes
       LLMNR setting: yes
MulticastDNS setting: no
  DNSOverTLS setting: no
      DNSSEC setting: no
    DNSSEC supported: no
  Current DNS Server: 8.8.8.8
         DNS Servers: 8.8.8.8
                      8.8.8.4

```

then I may test the original commands that failed:

```shell
dig jfrog-prod-use1-shared-virginia-main.s3.amazonaws.com
nslookup jfrog-prod-use1-shared-virginia-main.s3.amazonaws.com
```

both should complete with success very quickly
