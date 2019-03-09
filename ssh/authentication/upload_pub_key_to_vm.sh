#!/usr/bin/env bash

# read:
# http://www.linuxproblem.org/art_9.html

# I suddenly needed to type in password even after 
# uploading my pub key the vbox vm

# do this:
enforce_perm() {
    chmod 700 ~/.ssh
    chmod 640 ~/.ssh/authorized_keys
}

upload_pubkey() {
    cat .ssh/id_rsa.pub | ssh '<username>@<address>' 'cat >>~/.ssh/authorized_keys'
}