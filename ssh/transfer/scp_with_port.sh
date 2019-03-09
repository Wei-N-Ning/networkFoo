#!/usr/bin/env bash

# source:
# man scp

# use scp's special protocol syntax
copy_files_via_port_2222() {
    # use -P for port
    # scp 'options...' -P 2222 'local_filename' user@host:'remote_location' 
    scp -r aws-sec scp://weining@10.0.1.67:2222//var/tmp
}

