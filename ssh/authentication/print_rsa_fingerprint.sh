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


# motivation:
# there seems no good way to "view" the finger print of a RSA key pair other than
# using ssh agent that:
# 1. firstly adds the key pair (done via ssh-add)
# 2. secondly list the key pair (done via ssh-add -l)
# but calling ssh-add will affect the current calling environment,
# the follow recipe is to call ssh-agent in a subprocess hence avoiding 
# the pollution.
print_rsa_fingerprint() {
    # this sh process quickly terminates therefore the current
    # calling environment is unaffected
    # 
    # man page says:
    # If a command line is given, this is executed as a subprocess of the agent. 
    # When the command dies, so does the agent.
    # 
    # The idea is that the agent is run in the user's local PC, laptop, or terminal.  
    # Authentication data need not be stored on any other machine, and authentication 
    # passphrases never go over the network.  However, the connection to the agent is 
    # forwarded over SSH remote logins, and the user can thus use the privileges given 
    # by the identities anywhere in the network in a secure way.
    # 
    # clear all the entries in the calling environment
    ssh-add -D 
    # "view" the finger print
    ssh-agent sh -c 'ssh-add; ssh-add -l'
    # verify that the calling environment is unaffected 
    ssh-add -l

    # I can abuse this to also print the fingerprint of 
    # my encrypted key
    ssh-agent sh -c 'sshadd_macgnw_wei_admin' 
}
