#!/usr/bin/env bash

add_nickname() {
    cat >>~/.ssh/config <<"EOF"
Host awstk1
    hostname 54.252.141.241
    user ubuntu
EOF

    # instead of ssh ubuntu@...
    ssh awstk1 
}