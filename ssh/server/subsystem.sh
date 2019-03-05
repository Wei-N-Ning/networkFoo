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
