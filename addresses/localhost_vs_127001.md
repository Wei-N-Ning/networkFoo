# localhost v.s. 127.0.0.1

source: <https://github.com/trimstray/test-your-sysadmin-skills#simple-questions>

Well, the most likely difference is that you still have to do an actual lookup of localhost somewhere.

If you use 127.0.0.1, then (intelligent) software will just turn that directly into an IP address and use it. Some implementations of gethostbyname will detect the dotted format (and presumably the equivalent IPv6 format) and not do a lookup at all.

Otherwise, the name has to be resolved. And there's no guarantee that your hosts file will actually be used for that resolution (first, or at all) so localhost may become a totally different IP address.

By that I mean that, on some systems, a local hosts file can be bypassed. The host.conf file controls this on Linux (and many other Unices).

If you use a Unix domain socket it'll be slightly faster than using TCP/IP (because of the less overhead you have). Windows is using TCP/IP as a default, whereas Linux tries to use a Unix Domain Socket if you choose localhost and TCP/IP if you take 127.0.0.1.
