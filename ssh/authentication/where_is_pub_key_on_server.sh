#!/usr/bin/env bash

# keep wondering this...

# at CA, it uses a script callback (authorized key command) when 
# a visitor wants to access the server

# the script calls the AWS IAM to get the visitor's public key;
# the script defines AuthorizedKeyCommandUser as "iam"
# which is a god-user having access some secret;
# it is able to read and print the pub key of the login user 
# I need to find out how it finds the name of the login user
# NOTE
# this command (script) takes arguments which are 
# supplied via ssh client command
# NOTE
# the username is the only argument taken by this script - I realize
# the client side config (such as staging-cn.jump.config) defines
# the IAM username as the configure entry name
# this perhaps how things are connected...

# at the end of the callback script, the public key is given (echoed)
# to the server auth so that it can use it to compare with the
# private key of the visitor (leaves on visitor's own machine)

# a classic (and bad) approach is to store this pub key on the 
# visitor's home dir on the server in
# /home/<visitor>/.ssh/authorized_keys



