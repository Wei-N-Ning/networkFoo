#!/usr/bin/env bash

# source
# https://serverfault.com/questions/130482/how-to-check-sshd-log

inspect_server_auth_log() {
    # log in as root
    tail -f /var/log/auth.log

    # example of successful log in
    # Feb 11 00:54:24 ip-10-0-8-30 sshd[30572]: Accepted publickey for ubuntu from 10.0.0.7 port 59132 ssh2: RSA SHA256:nfzYUpzhMFXRETt3GBIzrT+ba/2sJ/J9cBMiCTxVSfE
    # Feb 11 00:54:24 ip-10-0-8-30 sshd[30572]: pam_unix(sshd:session): session opened for user ubuntu by (uid=0)
    # Feb 11 00:54:24 ip-10-0-8-30 systemd-logind[1131]: New session 110 of user ubuntu.
    # user log off
    # Feb 11 00:55:18 ip-10-0-8-30 sshd[30572]: pam_unix(sshd:session): session closed for user ubuntu
    # Feb 11 00:55:18 ip-10-0-8-30 systemd-logind[1131]: Removed session 110.
}

