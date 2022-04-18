#!/usr/bin/env bash

# I have seen this error message a lot at CA because their
# bastion hosts (and other backend hosts) get re-provisioned
# quite often

# question source:
# https://github.com/trimstray/test-your-sysadmin-skills

fast_but_risky() {
    :
    # When you reconnect to the same server, the SSH 
    # connection will verify the current public key matches 
    # the one you have saved in your known_hosts file. 
    # If the server's key has changed since the last time 
    # you connected to it, you will receive the above error.

    # delete the offending entry in the known_hosts file
    # meaning "press Yes"
}

secure() {
    :
    # Don't delete the entire known_hosts file as recommended 
    # by some people, this totally voids the point of the 
    # warning. It's a security feature to warn you that a man
    #  in the middle attack may have happened.

    # Before accepting the new host key, contact your/other 
    # system administrator for verification.
}
