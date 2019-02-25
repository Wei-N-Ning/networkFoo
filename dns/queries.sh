#!/usr/bin/env bash

# source
# networking for systems admin, L1659

# the domain name service is not the only source of information 
# on hostname to IP mappings 
# you can manually create these mappings on an individual 
# machine by using the host file
# /etc/hosts
# I often put entries in my hosts file for troubleshooting, 
# when I develop a new version of my web site I make a hosts 
# entry for w...com on my desktop, pointing to a development 
# server. This lets me verify that all of my links work 
# and that I haven't anything actively stupid
# In large enterprises, I recommend using your config management 
# system (Ansible, Puppet, Chef...) to maintain production
# hosts files

lookup() {
    host

    # response code
    # NOERROR
    # does not mean that the info is correct

    # NXDOMAIN
    # dns protocol worked but the dns does not contain any
    # records of the name you are looking for
    # get an answer: there is no such host

    # SERVFAIL
    # can not get an answer 

    host -v macgnw.com 

    # adv query
    dig macgnw.com
}

reverse_lookup() {
    host -v 89.134.95.52
}

