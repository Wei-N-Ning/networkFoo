#!/usr/bin/env bash

# read:
# https://medium.com/@jryancanty/just-in-time-ssh-provisioning-7b20d9736a07
: '
- manually update ~/.ssh/authorized_keys in VM for every user is NOT cool
- using Chef and explicity deployment pipeline leaves security gap
'

# https://gist.github.com/sivel/c68f601137ef9063efd7

# https://man.openbsd.org/sshd_config
# https://serverfault.com/questions/762817/how-is-the-authorizedkeyscommand-used-in-ssh

# disagreement:
# https://blog.heckel.xyz/2015/05/04/openssh-authorizedkeyscommand-with-fingerprint/ 

# example in CA infra code base:
# ack authorized_keys_command\.sh

# found:

# common/jump/bin/provision.sh
# 65:iam ALL=(root) NOPASSWD: /opt/iam/authorized_keys_command.sh, \
# 71:    sudo sed -i 's:#AuthorizedKeysCommand none:AuthorizedKeysCommand /opt/iam/authorized_keys_command.sh:g' /etc/ssh/sshd_config
# 73:    echo "AuthorizedKeysCommand /opt/iam/authorized_keys_command.sh" | sudo tee -a /etc/ssh/sshd_config

