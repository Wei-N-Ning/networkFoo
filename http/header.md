# Http Headers

source: youtube | Headers for Hackers- Wrangling HTTP Like a Pro

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

__content-type__ what type of data to receive

__content-length__ size of the data to receive

## no cache

this is sufficient:

Cache-Control: private, no-store

## meaningless to the broser

x-cache (and also x-...); added by CDN for debugging purpose

## stop anyone from framing your site

X-Frame-Options: SAMEREGION

Content-Security-Policy: frame-ancestors 'self'
