#!/usr/bin/env bash

# source: 
# https://gist.github.com/kraftb/9918106
# (reply #3)

# use two in memory file pipes instead of storing key fingerprints on disk.

keygen_inmem() {
    # I can even use ramfs 
    local pri="/tmp/mkey"
    local pub="/tmp/mkey.pub"

    # set up file pipes and ready to receive key data
    mkfifo "${pri}" "${pub}" && cat "${pri}" "${pub}" & echo "y" | \
        # keygen, save to the file pipes
        ssh-keygen -t rsa -b 1024 -C "IDDQDIDKFA" -f "${pri}"
        
    rm "${pri}" "${pub}"
}

keygen_inmem