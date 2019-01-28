#!/usr/bin/env bash

# source: ssh mastery L1442
# I'm working on my server A, and must copy a file 
# over to the server B. This presents a problem
# My private key isn't on A. 
# Copying the private key to a server is terrible
# security practice - you want your private key 
# on as few hosts as possible, and never on your 
# servers.

# the answer is to forward authentication request 
# back to your workstation. Agent forwarding is 
# exactly that.




