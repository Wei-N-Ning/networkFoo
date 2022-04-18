#!/usr/bin/env bash

# source:
# this came from udemy course: ssh beginner

# the scenario is:
# a web server is hosted on a VM on an annoymous port (not 80);
# packets visiting this server via http connection are forwarded 
# to port 80 via ssh forwarding;

create_web_server() {
    mkdir -p /tmp/sut/www
    cat >/tmp/sut/www/index.html <<"EOF"
<html>
<l>
there is a cow
there is
a cow
</l>
</html>
EOF
    local pyver=$( python --version 2>&1 | perl -ne '/(\d+)/ && print $1' )
    local args=""
    if [[ "${pyver}" == "2" ]]
    then
        args=( -m SimpleHTTPServer 32145 )
    else
        args=( -m http.server 32145 )
    fi
    ( cd /tmp/sut/www && python "${args[@]}" )
}

# read:
# how to turn off forwarding:
# https://superuser.com/questions/87014/how-do-i-remove-an-ssh-forwarded-port

etablishing_forwarding() {
    #      ____ port on the calling machine
    ssh -L 6080:localhost:32145 user@....
    #           ^^^^^^^^^^^^^^^ name:port on the VM
    # user@... to specify the login address of the VM

    # on public vm:
    # port 6080 is forwarded to
    # private vm:
    # localhost:32145, which hosts a web site
    # therefore one can visit the web site via:
    # public-ip:6080
}

# see:
# https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-ssh-tunnel-local.html

# ssh -i ~/mykeypair.pem -N -L 8157:ec2-###-##-##-###.compute-1.amazonaws.com:8088 hadoop@ec2-###-##-##-###.compute-1.amazonaws.com