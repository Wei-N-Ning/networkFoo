#!/usr/bin/env bash

# source:
# https://serverfault.com/questions/830388/authorizedkeyscommand-not-getting-executed

# Arguments to AuthorizedKeysCommand may be provided using the 
# following tokens, which will be expanded at runtime: %% is 
# replaced by a literal '%', %u is replaced by the username being 
# authenticated, %h is replaced by the home directory of the user 
# being authenticated, %t is replaced with the key type offered 
# for authentication, %f is replaced with the fingerprint of the 
# key, and %k is replaced with the key being offered for authentication. 
# If no arguments are specified then the username of the target user 
# will be supplied.

# //////// server side ////////

# the config file must specify the argument list
# AuthorizedKeysCommand /opt/auth/cmd %u %h %k %t %f
# AuthorizedKeysCommandUser root

# received arguments
# %u
# wein

# %h
# /Users/wein

# %k
# AAAAB3NzaC1yc2EAAAADAQABAAABAQCXfxwXQrU4ojScNs6qAK+1z5EHifN4u18C7x/PS1jT+ZksbuVlG5k6Bnj5oJ1rh6HoH7BdgDXVjiBBOqzO7NqLuq8NYpEvhNx4HBQTI1GUVpqAK0ZoIK9O7+tUTMgIOa7d0M3cw7UoDnt3R/td5X0SYyKYyf951miPPDPenAFgVZaGbDLM9T28QLepe0yemwFSXvetHNYnX+2r9ZFVrBsY0Tebr6dNWqf4wMbnDyvhlbzkcvmhi2nsOd2Ar+i9LLRsFM3xrwCRb1tSHZdxETYApSijKLRlEytlOb6E84a8qbyjvOHoFPANbrxzEvl9hxj4+2MmtR8Y382i8gPTc2Af 

# %t
# ssh-rsa

# %f
# SHA256:kpiQCOsMYjTuWChCWWm8UQ8P1ja/aY0Pfm8H3Mf7p5g

sudo bash <<"EOF"
cmddir=/opt/auth
cmd=${cmddir}/cmd

install_script() {
    rm -rf ${cmddir}
    mkdir ${cmddir}

    cat >${cmd} <<"SOURCE"
#!/bin/bash
echo $@ >/var/tmp/auth_args
SOURCE
    chmod -R 600 ${cmddir}
    chmod 700 ${cmd}
}

install_script
EOF

sudo $(which sshd) -f ./sshd_config_mock -p 2222 -d


# //////// client side ////////
# ssh wein@localhost -p 2222

