#!/usr/bin/env bash

# https://apple.stackexchange.com/questions/48502/how-can-i-permanently-add-my-ssh-private-key-to-keychain-so-it-is-automatically

# not to be mixed up with ~/.aws/cli/cache directory!

# there is an extre twist in jump server's /etc/ssh/sshd_config
# see authorized_keys_command.sh
# it looks up the key file from the current user name therefore the log in user 
# does not need to provide pem/-i !