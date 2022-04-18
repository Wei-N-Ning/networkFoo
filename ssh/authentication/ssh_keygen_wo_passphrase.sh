#!/usr/bin/env bash

# source: SSH definitive P130/150
# to generate an ssh key pair without passphrase, hence automating
# the whole process

demo_generate_keypair() {
    # The –N (OpenSSH) and –P (Tectia) options cause the generated 
    # key to be left unencrypted
    ssh-keygen -N '' -b 1024 -t rsa -f /var/tmp/thereisacow
}

run_sshd_with_keypair() {
    # the newly generated key pair can be used as hostkey
    /usr/sbin/sshd -h /var/tmp/thereisacow -p 2222 -f \
        /var/tmp/config -d
}

