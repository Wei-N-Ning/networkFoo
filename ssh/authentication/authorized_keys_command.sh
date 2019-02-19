#!/usr/bin/env bash

# read:
# https://medium.com/@jryancanty/just-in-time-ssh-provisioning-7b20d9736a07
: '
- manually update ~/.ssh/authorized_keys in VM for every user is NOT cool
- using Chef and explicity deployment pipeline leaves security gap
'
# //////// AuthorizedKeysCommand ////////

# Specifies a program to be used to look up the user's public keys.  
# The program must be owned by root, not writable by group or others
#  and specified by an absolute path.  Arguments to AuthorizedKeysCommand 
# accept the tokens described in the TOKENS section. If no arguments 
# are specified then the username of the target user is used.

# The program should produce on standard output zero or more lines of
#  authorized_keys output (see AUTHORIZED_KEYS in sshd(8)). If a key 
# supplied by AuthorizedKeysCommand does not successfully authenticate 
# and authorize the user then public key authentication continues using 
# the usual AuthorizedKeysFile files.  By default, no AuthorizedKeysCommand is run.

# //////// AuthorizedKeysCommandUser ////////

# Specifies the user	under whose account the	AuthorizedKeysCommand
# is	run.  It is recommended	to use a dedicated user	that has no
# other role	on the host than running authorized keys commands.  If
# AuthorizedKeysCommand is specified	but AuthorizedKeysCommandUser
# is	not, then sshd(8) will refuse to start.

# NOTE: the user must both exist in the host OS and has the privilege 
# to interface with external system (such as AWS) to retrieve the 
# public keys

# //////// Better SSH Authorized Keys Management ////////
# https://gist.github.com/sivel/c68f601137ef9063efd7
# 

# //////// troubleshoot AuthorizedKeysCommand failure ////////
# https://serverfault.com/questions/762817/how-is-the-authorizedkeyscommand-used-in-ssh
# You need to the set the AuthorizedKeysCommandUser parameter as well, 
# otherwise sshd fails to start. Also, make sure to heed all the other 
# requirements for AuthorizedKeysCommand laid out in sshd_config, e.g. 
# the script needs to be executable too.
#

# //////// side note: how to pass argument to authorized keys command ////////
# https://blog.heckel.xyz/2015/05/04/openssh-authorizedkeyscommand-with-fingerprint/ 
# 
# NOTE: this post assumes that one self-manages the secrets without using 
# an external vendor (AWS); the solution is to hash the user-supplied id
# and look up a prebuilt table
# note how the arguments are passed from client-side
#

# //////// example in CA infra code base: ////////
# ack authorized_keys_command\.sh
# found:
# common/jump/bin/provision.sh
# 65:iam ALL=(root) NOPASSWD: /opt/iam/authorized_keys_command.sh, \
# 71:    sudo sed -i 's:#AuthorizedKeysCommand none:AuthorizedKeysCommand /opt/iam/authorized_keys_command.sh:g' /etc/ssh/sshd_config
# 73:    echo "AuthorizedKeysCommand /opt/iam/authorized_keys_command.sh" | sudo tee -a /etc/ssh/sshd_config
# 

# //////// DEBUG authorized keys command failure ////////
# > make sure the inbound rules include port 2222
# > use one-short sshd debug mode
# > /usr/sbin/sshd -f /etc/ssh/sshd_config -p 2222 -d
# 
# here is the full log of a failed login attempt
# 
# debug1: sshd version OpenSSH_7.2, OpenSSL 1.0.2g  1 Mar 2016
# debug1: private host key #0: ssh-rsa SHA256:VtVVALIiCa6ZIfQmkknvvW3vuQvMfHtQUJNSGc3b9lk
# debug1: private host key #1: ssh-dss SHA256:6qr48U1Mt1Y6GOr61h1vSAJDQQCUR1XKdefi+H9dUkY
# debug1: private host key #2: ecdsa-sha2-nistp256 SHA256:lAGknR2hRWc1x6Q8CVSXymL2CgMNN7oSTQmCkiiXCMQ
# debug1: private host key #3: ssh-ed25519 SHA256:pkTccapn9uXUotvLA5CH7E9zy7m0eaVlvO7VGG2d20w
# debug1: rexec_argv[0]='/usr/sbin/sshd'
# debug1: rexec_argv[1]='-f'
# debug1: rexec_argv[2]='/etc/ssh/sshd_config'
# debug1: rexec_argv[3]='-p'
# debug1: rexec_argv[4]='2222'
# debug1: rexec_argv[5]='-d'
# debug1: Set /proc/self/oom_score_adj from 0 to -1000
# debug1: Bind to port 2222 on 0.0.0.0.
# Server listening on 0.0.0.0 port 2222.
# debug1: Bind to port 2222 on ::.
# Server listening on :: port 2222.
# debug1: Server will not fork when running in debugging mode.
# debug1: rexec start in 5 out 5 newsock 5 pipe -1 sock 8
# debug1: inetd sockets after dupping: 3, 3
# Connection from 202.159.183.180 port 58247 on 10.0.0.8 port 2222
# debug1: Client protocol version 2.0; client software version OpenSSH_7.8
# debug1: match: OpenSSH_7.8 pat OpenSSH* compat 0x04000000
# debug1: Enabling compatibility mode for protocol 2.0
# debug1: Local version string SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.7
# debug1: permanently_set_uid: 110/65534 [preauth]
# debug1: list_hostkey_types: ssh-rsa,rsa-sha2-512,rsa-sha2-256,ecdsa-sha2-nistp256,ssh-ed25519 [preauth]
# debug1: SSH2_MSG_KEXINIT sent [preauth]
# debug1: SSH2_MSG_KEXINIT received [preauth]
# debug1: kex: algorithm: curve25519-sha256@libssh.org [preauth]
# debug1: kex: host key algorithm: ecdsa-sha2-nistp256 [preauth]
# debug1: kex: client->server cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none [preauth]
# debug1: kex: server->client cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none [preauth]
# debug1: expecting SSH2_MSG_KEX_ECDH_INIT [preauth]
# debug1: rekey after 134217728 blocks [preauth]
# debug1: SSH2_MSG_NEWKEYS sent [preauth]
# debug1: expecting SSH2_MSG_NEWKEYS [preauth]
# debug1: SSH2_MSG_NEWKEYS received [preauth]
# debug1: rekey after 134217728 blocks [preauth]
# debug1: KEX done [preauth]
# debug1: userauth-request for user developer service ssh-connection method none [preauth]
# debug1: attempt 0 failures 0 [preauth]
# Invalid user developer from 202.159.183.180
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# input_userauth_request: invalid user developer [preauth]
# debug1: PAM: initializing for "developer"
# debug1: PAM: setting PAM_RHOST to "202.159.183.180"
# debug1: PAM: setting PAM_TTY to "ssh"
# debug1: userauth-request for user developer service ssh-connection method publickey [preauth]
# debug1: attempt 1 failures 0 [preauth]
# debug1: userauth_pubkey: test whether pkalg/pkblob are acceptable for RSA SHA256:agJ0d0+AyhCeHmb/ddfs3oq+lVprR5pvVD6X4kgkz54 [preauth]
# Connection closed by 202.159.183.180 port 58247 [preauth]
# debug1: do_cleanup [preauth]
# debug1: monitor_read_log: child log fd closed
# debug1: do_cleanup
# debug1: PAM: cleanup
# debug1: Killing privsep child 20644
# debug1: audit_event: unhandled event 12

# the error is easily spotted - the login user does not exist
# it was a client side bug


