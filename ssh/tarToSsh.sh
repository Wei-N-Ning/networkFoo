#!/usr/bin/env bash

# note the use of ( -f - ), which prints the binary content of the 
# archive to stdout;
# this output stream is then received by cat in the remote end and 
# redirected to a file
run() {
    rm -rf /tmp/doom
    mkdir /tmp/doom
    echo "iddqd idkfa" > /tmp/doom/map
    tar zcvf - /tmp/doom | ssh wein@107.170.4.117 "cat > /tmp/doom_back.tgz"
}

run

