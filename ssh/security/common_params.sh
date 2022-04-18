#!/usr/bin/env bash

common_security_params_server() {
    :
    # disallow password login; only key pairs
    # PasswordAuthentication no

    # disallow root user login
    # PermitRootLogin no

    # set a cap on the number of authentication errors to prevent
    # brutal force
    # MaxAuthTries 6

    # disallow ssh keypairs without passphrase
    # source: https://serverfault.com/questions/589680/disallow-ssh-keys-without-passphrase
    cat /etc/ssh/sshd_config
    # RequiredAuthentications2 pubkey,password
}

common_security_params_client() {
    :
    # stop using RSA (the default key algorithm)!!
    ssh-keygen -t ed25519

    # use agent forwarding and stop storing private key on
    # bastion host!
    ssh -N -p 2222 -L 2222:192.168.0.7:22 wein@192.168.0.6
}
