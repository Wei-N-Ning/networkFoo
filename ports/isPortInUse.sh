#!/usr/bin/env bash
# $1: port
ports_in_use() {
    # see:
    # https://stackoverflow.com/questions/3321829/how-do-i-best-pass-arguments-to-a-perl-one-liner
    cat /etc/services | perl -slane '@F[1] =~ /^$portnum/ && print $_' -- -portnum=${1:?"missing port number"}

    # see also:
    # Why is /etc/services full of email addresses?
    # https://discussions.apple.com/thread/460081

}

ports_in_use $@