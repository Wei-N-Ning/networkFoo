#!/usr/bin/env bash

# the file created by this dummy subsystem is 
# -rw-r--r--   1 weining  wheel     315  5 Mar 15:48 subsystem_thereisacow
# which confirms that it is executed by the login user
install_subsystem() {
    rm -f /var/tmp/thereisacow
    cat >/var/tmp/thereisacow <<"EOF"
#!/bin/sh

perl -w -E 'my $text = `ls /var/tmp`;
open(my $fh, ">/var/tmp/subsystem_thereisacow");
say $fh $text;'
EOF
    chmod a+x /var/tmp/thereisacow
}

define_subsystem_in_conf() {
    : <<"TEXT"
115 Subsystem   sftp    /usr/lib/openssh/sftp-server
116 Subsystem   thereisacow /var/tmp/thereisacow
117 AcceptEnv SUBSYSTEM_ARGS
TEXT
    # client then use SUBSYSTEM_ARGS to pass argument to the subsystem
    # SSH defintive 2nd P/331
    # /////////
    # open ssh uses the remote command as the subsystem name: 
    # this must be specified last on the ssh command line
    # /////////
    SUBSYSTEM_ARGS='{"a": 123}' \
    ssh -s -o 'SendEnv=SUBSYSTEM_ARGS' h6 thereisacow

    # the content of the argument can be protected by base64

}

