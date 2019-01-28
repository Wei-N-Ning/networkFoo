#!/usr/bin/env bash

# now that you have a working key-based authentication,
# the smart thing to do is to disable password based 
# authentication

PasswordAuthentication no

# when making changes to your ssh/sshd config, do not 
# log out your current ssh session; 
# use external configure file and custom port to validate 
# the changes 

