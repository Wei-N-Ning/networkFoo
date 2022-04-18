#!/usr/bin/env bash

# source:
# https://www.ssh.com/ssh/copy-id
ssh-copy-id -i ~/.ssh/mykey user@host

# note: some old entry in known_host file might trigger an error
# just delete the offending line

