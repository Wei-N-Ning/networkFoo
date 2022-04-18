#!/usr/bin/env bash

# source: ssh mastery 

strict_host_key_checking() {
# each line contains the machine's hostname (some.thing), host
# key type (ecdsa.sh2....) and the public key itself

# in other environments it is acceptable to automatically add new
# keys to the cache.

# if you want ssh to refuse to connect to any host that doesn't
# have an entry in known_hosts, set 
StrictHostKeyChecking yes

# the only way for the client to connect is to add the host key
# to the known_hosts, presumably from a central repository provided
# by the sysadmin

#
}

hash_known_hosts() {
    # ssh mastery L938

    # hash all existing known hosts and create a backup file: .old
    ssh-keygen -H 

    # query one known host
    ssh-keygen -F 192.168.0.16

    # here is how to unhash all known hosts 
    # http://www.physics.drexel.edu/~wking/unfolding-disasters-old/posts/Monkeysphere/unhash-known-hosts.sh
}



