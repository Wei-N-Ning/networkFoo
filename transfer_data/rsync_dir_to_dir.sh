#!/usr/bin/env bash

# sync a local directory A to another local directory B
# and delete all the extraneous files B

rsync -av --progress --delete 'A' 'B'
: <<HELP

    -a, --archive - archive mode
    --delete - delete extraneous files from dest dirs
    -v, --verbose - verbose mode (increase verbosity)
    --progress - show progress during transfer

HELP

