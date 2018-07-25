#!/usr/bin/env bash

# showing how to transfer an entire directory (with subdirs etc.)
# via tcp socket over the network
# the receiving end recreates the directory tree

STMP=${TMPDIR:-/tmp}/sut
TESTFILE=$( dirname ${0} )/../dd.tar

tearDown() {
    rm -rf ${STMP}
}

setUp() {
    set -e
    tearDown
    mkdir -p ${STMP}
}

# create a mock dir:
# sut/products/
#            ./files...
# sut/products/versions/
#                     ./files...
generateData() {
    local PDIR=${STMP}/products
    local VDIR=${PDIR}/versions
    mkdir -p ${PDIR}
    echo "doom" >${STMP}/config.ini
    mkdir -p ${VDIR}
    echo "dos" >${VDIR}/01.ini
    tar zxv -f ${TESTFILE} --directory=${PDIR} >/dev/null 2>&1
    if [[ $? != 0 ]]
    then
        echo "fail to populate test directory"
        exit 1
    fi
}

# tar the entire tree ${STMP} to an archive, 
# send the archive over a tcp socket to the network (localhost:9988)
# the receiver untar the archieve in ${STMP}
# this creates ${STMP}/tmp/.../products, versions etc...

# notes:
# > the server side tar unpacks the archive to the directory specified 
#   by --directory 
# > the server side tar receives the archive via stdin ( -f - )
# > the client side tar packs the directory and prints the output 
#   to stdout ( -f - ); to test this alone do:
# tar -czf - /directory/to/archive/* | wc
# or
# tar -czf - /directory/to/archive/* >/output/file/path
doTransfer() {
    cd ${HOME}
    nc -l 127.0.0.1 9988 | tar xzvf - --directory ${STMP} &
    sleep 0.1
    tar -czf - ${STMP}/* | nc 127.0.0.1 9988
    wait
}

setUp
generateData
doTransfer
tearDown

