#!/usr/bin/env bash

# read:
# https://blog.tinned-software.net/generate-public-ssh-key-from-private-ssh-key/

# when the public key is missing, one can generate it from
# the private key

# The -y option will read a private SSH key file and prints an SSH public key to stdout. 

# -f: Specifies the filename of the key file.

# If the key has a password set, the password will be required to generate the public key.
get_pub_from_pri() {
    diff <(ssh-keygen -y -f ~/.ssh/id_rsa) ~/.ssh/id_rsa.pub

    # the diff show identical pub key fingerprint;
    # however .pub file stores the host address (which is missing
    # from the first output) - this is the "comment" part of the 
    # key-pair
}

