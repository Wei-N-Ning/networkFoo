# https

aka

http over tls; transport layer security; https://en.wikipedia.org/wiki/Transport_Layer_Security

http over ssl; secure sockets layer; https://www.digicert.com/ssl/

http secure

## ssl certificate

conceptual id card for a website; to be purchased

## why it's a bad idea using GET to send data

using GET meaning the data has to be part of the url - not secure;
POST does not have this issue

## HTTP status code

1xx: informational - request received/processing

2xx: success - successfully received, understood and accepted

```text
200: ok
201: ok created
```

3xx: redirect - further action must be taken/redirect

```text
301: moved to new URL
304: not modified (cached version)
```

4xx: client error - request does not have what it needs

```text
400: bad request
401: unauthorized
404: not found
```

5xx: server error - server failed to fulfil an apparent valid request

```text
500: internal server error
```
