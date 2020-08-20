#!/usr/bin/env bash

################################################################
: <<"TEXT"
dns resolves hostname to ip, ip to hostname (reverse), and
hostname to hostname

see: lookup.sh for DNS record breakdown

(ip to hostname) PTR

the package on linux that handles DNS requests

apt search bind | grep BIND

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

  Documentation for BIND
  LDAP back-end plug-in for BIND
  Utilities for BIND
  DNS statistics RRDtool frontend for BIND9
  Clients provided with BIND
  parser for BIND Config files
  Parser class for BIND configuration files
  Static Libraries and Headers used by BIND
  Development files for the exported BIND libraries
  BIND9 Shared Library used by BIND
  DNS Shared Library used by BIND
  DNS Shared Library used by BIND
  ISC Shared Library used by BIND
  Command Channel Library used by BIND
  Command Channel Library used by BIND
  Config File Handling Library used by BIND
  Lightweight Resolver Library used by BIND
  fast BIND-style zonefile parser on top of Net::DNS
  BIND backend for PowerDNS


TEXT
################################################################

# source
# networking for systems admin, L1452

# DNS runs on TCP and UDP, using **port 53** on both
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





