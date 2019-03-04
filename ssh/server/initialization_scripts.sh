#!/usr/bin/env bash

install_rc_script() {
    local rc_filename=${1:?"missing filename"}
    cat >"${rc_filename}" <<EOF
#!/bin/sh
echo "executing ${rc_filename}"
EOF
    cat >>"${rc_filename}" <<"EOF"
perl -w -E 'use DateTime;
my $dt3 = DateTime->now(time_zone => "local");
my $timestr = $dt3->strftime("%Y_%m_%d_%H_%M_%S");
my $filename = "/var/tmp/$ENV{USER}_$timestr";
open(my $fh, ">$filename") or die "can not open $filename";
say $fh "thereisacow";'
echo "+ DONE"
EOF
}

uninstall() {
    sudo rm -f /etc/ssh/sshrc ~/.ssh/rc
}

# //// read this ////
# /etc/ssh/sshrc and ~/.ssh/rc are mutual exclusive

# http://manpages.ubuntu.com/manpages/bionic/man8/sshd.8.html#sshrc

# If this file (~/.ssh/rc) does not exist, /etc/ssh/sshrc is run, 
# and if that does not exist either, xauth is used to add the cookie.

# also note that outputs to shell from /etc/ssh/sshrc do not 
# show up in sshd debug messages;
# outputs from ~/.ssh/rc on the other hand do show up on the
# caller's side (not server side) 
install_etc_ssh_sshrc() {
    sudo su
    install_rc_script "/etc/ssh/sshrc"
}

install_home_ssh_rc() {
    install_rc_script "${HOME}/.ssh/rc"
}

if [[ "${1}" == "etc" ]]; then
    install_etc_ssh_sshrc
elif [[ "${1}" == "home" ]]; then
    install_home_ssh_rc
elif [[ "${1}" == "un" ]]; then
    uninstall
fi
