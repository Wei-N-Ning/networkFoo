#!/usr/bin/env bash

# keep wondering this...

# at CA, it uses a script callback when a visitor wants to 
# access the server

# the script calls the AWS IAM to get the visitor's public key 
# (the IAM username is probably passed by environment variable)

# at the end of the callback script, the public key is given (echoed)
# to the server auth so that it can use it to compare with the
# private key of the visitor (leaves on visitor's own machine)

# a classic (and bad) approach is to store this pub key on the 
# visitor's home dir on the server in
# /home/<visitor>/.ssh/authorized_keys



