#!/usr/bin/env bash

# note the use of ( -f - ), which prints the binary content of the 
# archive to stdout;
# this output stream is then received by cat in the remote end and 
# redirected to a file
tar_tmpdir_to_server() {
    rm -rf /tmp/doom
    mkdir /tmp/doom
    echo "iddqd idkfa" > /tmp/doom/map
    tar zcvf - /tmp/doom | ssh wein@107.170.4.117 "cat > /tmp/doom_back.tgz"
}

tar_thisdir_to_server() {
    # transfer an entire directory by
    # - compressing it to tar
    # - copying it to server /tmp
    # - decompressing it to ${HOME}
    ( cd ../../../ && tar zcvf - networkfoo ) | ssh -i mortalenginex2.enc awstk1 'cat >/tmp/nf.tgz; tar xaf /tmp/nf.tgz'
}

tar_tmpdir_to_server

