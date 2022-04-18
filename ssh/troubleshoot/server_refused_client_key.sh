#!/usr/bin/env bash

client_side() {
    :
    # enable verbosity, -v, -vv

    # CA examples:
    # - user's pub key is never added to the server; user has
    #   minted a new keypair but hasn't uploaded to aws
    # - user is not added to certain aws IAM group, because the
    #   jump-script (authentication script) relies on this grp
    #   perm
}

server_side() {
    cat /etc/ssh/sshd_config
    # LogLevel=VERBOSE

    cat /var/log/auth.log /var/log/secure /var/log/audit/audit.log
    # 'Failed password, Failed\|Failure'
    grep 'sshd' /var/log/auth.log

    # CA examples:
    # - bastion ssh server dies; port 22 is disabled
    # - bastion is not initialized properly (no user pub keys etc)
    # - the authentication script invoked by ssh connection throws
    #   an error but is not seen
}

to_debug() {
    :

    # if I can still log in on the bastion server using my
    # keypair, I can create a new, separate ssh server using
    # the one-shot method; this should operate on a different
    # port and I should turn verbosity to the maximum

    # let the user ssh-to this special port, turn on verbosity
    
    # observe the error message on the server
}
