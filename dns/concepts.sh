#!/usr/bin/env bash

# source
# networking for systems admin, L1452

# DNS runs on TCP and UDP, using port 53 on both
# every network needs a DNS server, also called a nameserver, 
# to gather this information for you.

# a nameserver is a piece of software that searches for and 
# collects address and hostname mappings. Whenever you visit 
# a web page your computer makes a DNS request to a 
# nameserver. The nameserver checks its local cache to see if 
# it already has an answer. If the nameserver has a cached
# answer it sends the information to the client,
# if the nameserver does not have that info it queries the 
# Internet to get an answer

# L1513
# DNS was designed as a general purpose configuration database,
# mostly widely used to map IP to hostnames and back...
# it worked, so over the years people have jammed all sorts 
# of interesting things into zone records.
# they got away with it so people added more data types .... 

# when you find incorrect DNS information, see if it is coming
# from the host's local cache, the recursive nameserver's 
# cache or the authoritative server

# when you suspect a DNS problem, check to see if you are 
# getting an answer from a nameserver or a local cache.





