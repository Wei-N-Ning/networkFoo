# Http Headers

source: youtube | Headers for Hackers- Wrangling HTTP Like a Pro

check this: <https://securityheaders.com/>

## Http 1.0

host more than one site per ip address

run `curl -v example.com 80` or better `curl -I example.com`

-I, --head
(HTTP FTP FILE) Fetch the headers only!

```text
* Rebuilt URL to: example.com/
*   Trying 93.184.216.34...
* TCP_NODELAY set
* Connected to example.com (93.184.216.34) port 80 (#0)
> GET / HTTP/1.1
> Host: example.com
> User-Agent: curl/7.54.0
> Accept: */*
>
< HTTP/1.1 200 OK
< Cache-Control: max-age=604800
< Content-Type: text/html; charset=UTF-8
< Date: Mon, 04 Nov 2019 05:30:46 GMT
< Etag: "3147526947+ident"
< Expires: Mon, 11 Nov 2019 05:30:46 GMT
< Last-Modified: Thu, 17 Oct 2019 07:18:26 GMT
< Server: ECS (oxr/831E)
< Vary: Accept-Encoding
< X-Cache: HIT
< Content-Length: 1256
<
```

or (if using the second form)

```text
HTTP/1.1 200 OK
Content-Encoding: gzip
Accept-Ranges: bytes
Cache-Control: max-age=604800
Content-Type: text/html; charset=UTF-8
Date: Mon, 04 Nov 2019 05:42:11 GMT
Etag: "3147526947"
Expires: Mon, 11 Nov 2019 05:42:11 GMT
Last-Modified: Thu, 17 Oct 2019 07:18:26 GMT
Server: ECS (oxr/831E)
X-Cache: HIT
Content-Length: 648
```

**content-type** what type of data to receive

**content-length** size of the data to receive

## no cache

this is sufficient:

Cache-Control: private, no-store

## meaningless to the browser

x-cache (and also x-...); added by CDN for debugging purpose

## stop anyone from framing your site

X-Frame-Options: SAMEREGION

or better (better spec, better written, more consistent behaviors):

Content-Security-Policy: frame-ancestors 'self'

MY NOTE:

this gave me a more realistic header (the url points to a CA design that I'm allowed to open and edit)

`curl -I https://www.canva.com/design/DADZPanhTkk/i2_rqZiVzw61V4ou_7eTPQ/view?utm_content=DADZPanhTkk&utm_campaign=designshare&utm_medium=link&utm_source=sharebutton`

```text
[1] 96716
[2] 96717
[3] 96718
weining@BFG9000-2: ~/work/canva/infrastructure$ HTTP/2 200
date: Mon, 04 Nov 2019 06:17:18 GMT
content-type: text/html;charset=utf-8
set-cookie: __cfduid=d1ff6a293d6badcc839b9c278c2039b161572848237; expires=Tue, 03-Nov-20 06:17:17 GMT; path=/; domain=.canva.com; HttpOnly; Secure
referrer-policy: strict-origin-when-cross-origin
x-content-type-options: nosniff
x-xss-protection: 1; mode=block
strict-transport-security: max-age=31536000; includeSubDomains; preload
x-frame-options: deny
content-security-policy: frame-ancestors 'none';
set-cookie: CDI=81121465-9b93-4067-81e1-1a87e4044c73; Path=/; Expires=Thu, 01-Nov-2029 06:17:18 GMT; Max-Age=315360000; Secure; HttpOnly
expires: Thu, 01 Jan 1970 00:00:00 GMT
pragma: no-cache
cache-control: no-cache
cache-control: no-store
content-language: en
set-cookie: CPA=anPzJ6UaQk4L_gfXJkBCcLJscWn6KeoZIkJYz2-mulU6Gxqap3ESEdHvF0FiXpEmv9pyPzO3Gm7WcfJ4oIf9wOQft_2nEIS_hJK_KHFlvIXuPjBurC4RfOHKj15Ck7V1S9s6frIUWmHcu-r02YUoTfhTPkDXcfaZhEblCorB7uPucCFiHFtOZU7S1Inj3ptcCfy4QqRJCIczjlRoFb2l-XnZipXildNXmKyj_M02QywW6FMfjX2_Uf-8ugu5M-bmUlk0jvDP6YkDNJNAEBNTFq2nQ01LTTk4mxRBqIs3bpMX4I1c; Path=/; Domain=.canva.com; Expires=Mon, 04-Nov-2019 09:17:18 GMT; Max-Age=10800; Secure; HttpOnly
accept-ranges: bytes
cf-cache-status: DYNAMIC
alt-svc: h3-23=":443"; ma=86400
expect-ct: max-age=604800, report-uri="https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct"
server: cloudflare
cf-ray: 530476ced979d699-SYD
```

## the headers we want, best practices

### content-security-policy (csp)

a list of origins (including `self`) your page is permitted to make
connections to, in order to load resources; can subdivide by type of
resources: (these origins for scripts; these origins for images etc.)

create a firewall in the browser

problem: can grow to REALLY large (10kb)

no `unsafe-inline`, `unsafe-eval` !!!

### strict-transport-security

always connect over TLS, even for first request

kill off unsecure HTTP once and for all

the `preload` directive: to tell all the browser instance (such as Chrome)
to follow suit

is aggressive; can be devastating if TLS is not set up correctly

### referrer-policy

"if I search for something, my search string might be leaked to
the 3rd party site"

this policy is to limit the amount of information shared

### access-control-\*

adding them degrades security
