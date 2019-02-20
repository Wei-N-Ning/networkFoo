#!/usr/bin/env bash

# https://apple.stackexchange.com/questions/48502/how-can-i-permanently-add-my-ssh-private-key-to-keychain-so-it-is-automatically

# not to be mixed up with ~/.aws/cli/cache directory!

# there is an extre twist in jump server's /etc/ssh/sshd_config
# see CA's authorized_keys_command.sh
# it looks up the key file use user "iam" (which is sort of a god-user) 
# therefore the login user does not need to provide pem/-i !

# good articles and Funtoo linux (Gentoo linux variation)

# what is keychain concept
# https://www.funtoo.org/Keychain

# openssh key management part 1, 2, 3
# https://www.funtoo.org/OpenSSH_Key_Management,_Part_1
# https://www.funtoo.org/OpenSSH_Key_Management,_Part_2
# https://www.funtoo.org/OpenSSH_Key_Management,_Part_3
# Funtoo keychain util Github repo:
# https://github.com/funtoo/keychain
# Funtoo linux repo:
# https://github.com/funtoo

