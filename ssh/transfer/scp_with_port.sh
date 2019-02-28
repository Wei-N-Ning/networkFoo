#!/usr/bin/env bash

# source:
# man scp

# use scp's special protocol syntax
copy_files_via_port_2222() {
    scp -r aws-sec scp://weining@10.0.1.67:2222//var/tmp
}

