#!/usr/bin/env bash 

# motivation:
# ssh-add records the finger prints of the pub key
# how can one verify if a key pair is recorded in ssh-agent?

# source:
# https://stackoverflow.com/questions/3828164/how-do-i-access-my-ssh-public-key
# see "you may want to print you RSA fingerprint "

# see also ssh-agent man page
# DESCRIPTION
    #  ssh-agent is a program to hold private keys used for public key authentication (RSA, DSA, ECDSA, Ed25519).  ssh-agent is
    #  usually started in the beginning of an X-session or a login session, and all other windows or programs are started as
    #  clients to the ssh-agent program.  Through use of environment variables the agent can be located and automatically used
    #  for authentication when logging in to other machines using ssh(1).

print_rsa_fingerprint() {
    # this sh process quickly terminates therefore the current
    # calling environment is unaffected
    ssh-agent sh -c 'ssh-add; ssh-add -l'

    # I can abuse this to also print the fingerprint of 
    # my encrypted key
    ssh-agent sh -c 'sshadd_macgnw_wei_admin' 
}
