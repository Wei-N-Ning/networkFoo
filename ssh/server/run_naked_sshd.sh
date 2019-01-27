#!/usr/bin/env bash

# source: ssh mastery L298

run_naked_sshd() {
    # the motivation is to debug ssh server config 
    # one can run sshd server process with sudo 
    # tested on u18 vbox

    sudo su
    cp /etc/ssh/sshd_config /var/tmp/sshd_config.test

    # make changes to the configure file
    vim /var/tmp/sshd_config.test
    
    # this is to workaround an error thrown from sshd:
    # Missing privilege separation directory
    # see: https://github.com/ansible/ansible-container/issues/141
    mkdir -p /var/run/sshd
    
    cd /var/tmp
    service sshd stop
    
    # launch sshd with the test configure file and a custom port number
    # the launcher will return immediately; observe the sshd process by
    # ps ax | grep -i sshd
    /usr/sbin/sshd -f sshd_config.test -p 2222

    # to connect to the server from mac (knowing the ip of u18 vbox)
    ssh 192.168.0.16 -p 2222

    # verify that both the privileged process and the unpriviledged
    # process are created server-side
    ps ax | grep -i sshd
}

debugging_naked_sshd() {
    # -d flag tells sshd to run in fg debugging mode without 
    # detaching from the controlling terminal
    # in debugging mode, sshd can only handle a single login request, 
    # NOT ONE REUQEST AT A TIME. It processes one login or login 
    # attempt and exits. 
    # Don't do it in production, run it on an alternate port. 
    
    # server
    /usr/sbin/sshd -f /path/to/conf.test -p 2222 -d
    # to increase the verbosity: try -dd and -ddd

    # client
    ssh 192.168.0.16 -p 2222
    cat <<"EOF"
debug1: sshd version OpenSSH_7.6, OpenSSL 1.0.2n  7 Dec 2017
debug1: private host key #0: ssh-rsa SHA256:BJNbihv1mEXbXO5SvzEBCCJzcluB21AbJ4jMqHOYqqY
debug1: private host key #1: ecdsa-sha2-nistp256 SHA256:XJ8eBGnvX32cSZ3EUZC/Enmqc99OKEQC9LOD0ZVr/Tc
debug1: private host key #2: ssh-ed25519 SHA256:wtb/7WKhEQlIAEewYx5MVHCG4QIPhYxAk7t0H8pliuc
debug1: rexec_argv[0]='/usr/sbin/sshd'
debug1: rexec_argv[1]='-f'
debug1: rexec_argv[2]='sshd_config'
debug1: rexec_argv[3]='-p'
debug1: rexec_argv[4]='2222'
debug1: rexec_argv[5]='-d'
debug1: Set /proc/self/oom_score_adj from 0 to -1000
debug1: Bind to port 2222 on 0.0.0.0.
Server listening on 0.0.0.0 port 2222.
debug1: Bind to port 2222 on ::.
Server listening on :: port 2222.
debug1: Server will not fork when running in debugging mode.
debug1: rexec start in 5 out 5 newsock 5 pipe -1 sock 8
debug1: inetd sockets after dupping: 3, 3
Connection from 192.168.0.11 port 55113 on 192.168.0.16 port 2222
debug1: Client protocol version 2.0; client software version OpenSSH_7.9
debug1: match: OpenSSH_7.9 pat OpenSSH* compat 0x04000000
debug1: Local version string SSH-2.0-OpenSSH_7.6p1 Ubuntu-4ubuntu0.1
debug1: permanently_set_uid: 110/65534 [preauth]
debug1: list_hostkey_types: ssh-rsa,rsa-sha2-512,rsa-sha2-256,ecdsa-sha2-nistp256,ssh-ed25519 [preauth]
debug1: SSH2_MSG_KEXINIT sent [preauth]
debug1: SSH2_MSG_KEXINIT received [preauth]
debug1: kex: algorithm: curve25519-sha256 [preauth]
debug1: kex: host key algorithm: ecdsa-sha2-nistp256 [preauth]
debug1: kex: client->server cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none [preauth]
debug1: kex: server->client cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none [preauth]
debug1: expecting SSH2_MSG_KEX_ECDH_INIT [preauth]
debug1: rekey after 134217728 blocks [preauth]
debug1: SSH2_MSG_NEWKEYS sent [preauth]
debug1: expecting SSH2_MSG_NEWKEYS [preauth]
debug1: SSH2_MSG_NEWKEYS received [preauth]
debug1: rekey after 134217728 blocks [preauth]
debug1: KEX done [preauth]
debug1: userauth-request for user wein service ssh-connection method none [preauth]
debug1: attempt 0 failures 0 [preauth]
debug1: PAM: initializing for "wein"
debug1: PAM: setting PAM_RHOST to "192.168.0.11"
debug1: PAM: setting PAM_TTY to "ssh"
debug1: userauth-request for user wein service ssh-connection method publickey [preauth]
debug1: attempt 1 failures 0 [preauth]
debug1: userauth_pubkey: test whether pkalg/pkblob are acceptable for RSA SHA256:kpiQCOsMYjTuWChCWWm8UQ8P1ja/aY0Pfm8H3Mf7p5g [preauth]
debug1: temporarily_use_uid: 1000/1000 (e=0/0)
debug1: trying public key file /home/wein/.ssh/authorized_keys
debug1: fd 4 clearing O_NONBLOCK
debug1: matching key found: file /home/wein/.ssh/authorized_keys, line 1 RSA SHA256:kpiQCOsMYjTuWChCWWm8UQ8P1ja/aY0Pfm8H3Mf7p5g
debug1: restore_uid: 0/0
Postponed publickey for wein from 192.168.0.11 port 55113 ssh2 [preauth]
debug1: userauth-request for user wein service ssh-connection method publickey [preauth]
debug1: attempt 2 failures 0 [preauth]
debug1: temporarily_use_uid: 1000/1000 (e=0/0)
debug1: trying public key file /home/wein/.ssh/authorized_keys
debug1: fd 4 clearing O_NONBLOCK
debug1: matching key found: file /home/wein/.ssh/authorized_keys, line 1 RSA SHA256:kpiQCOsMYjTuWChCWWm8UQ8P1ja/aY0Pfm8H3Mf7p5g
debug1: restore_uid: 0/0
debug1: do_pam_account: called
Accepted publickey for wein from 192.168.0.11 port 55113 ssh2: RSA SHA256:kpiQCOsMYjTuWChCWWm8UQ8P1ja/aY0Pfm8H3Mf7p5g
debug1: monitor_child_preauth: wein has been authenticated by privileged process
debug1: monitor_read_log: child log fd closed
debug1: PAM: establishing credentials
User child is on pid 2178
debug1: SELinux support disabled
debug1: PAM: establishing credentials
debug1: permanently_set_uid: 1000/1000
debug1: rekey after 134217728 blocks
debug1: rekey after 134217728 blocks
debug1: ssh_packet_set_postauth: called
debug1: Entering interactive session for SSH2.
debug1: server_init_dispatch
debug1: server_input_channel_open: ctype session rchan 0 win 1048576 max 16384
debug1: input_session_request
debug1: channel 0: new [server-session]
debug1: session_new: session 0
debug1: session_open: channel 0
debug1: session_open: session 0: link with channel 0
debug1: server_input_channel_open: confirm session
debug1: server_input_global_request: rtype no-more-sessions@openssh.com want_reply 0
debug1: server_input_channel_req: channel 0 request pty-req reply 1
debug1: session_by_channel: session 0 channel 0
debug1: session_input_channel_req: session 0 req pty-req
debug1: Allocating pty.
debug1: session_new: session 0
debug1: SELinux support disabled
debug1: session_pty_req: session 0 alloc /dev/pts/1
debug1: Ignoring unsupported tty mode opcode 11 (0xb)
debug1: Ignoring unsupported tty mode opcode 17 (0x11)
debug1: server_input_channel_req: channel 0 request env reply 0
debug1: session_by_channel: session 0 channel 0
debug1: session_input_channel_req: session 0 req env
debug1: server_input_channel_req: channel 0 request shell reply 1
debug1: session_by_channel: session 0 channel 0
debug1: session_input_channel_req: session 0 req shell
Starting session: shell on pts/1 for wein from 192.168.0.11 port 55113 id 0
debug1: Setting controlling tty using TIOCSCTTY.

// log off
debug1: Received SIGCHLD.
debug1: session_by_pid: pid 2179
debug1: session_exit_message: session 0 channel 0 pid 2179
debug1: session_exit_message: release channel 0
debug1: session_by_tty: session 0 tty /dev/pts/1
debug1: session_pty_cleanup: session 0 release /dev/pts/1
Received disconnect from 192.168.0.11 port 55113:11: disconnected by user
Disconnected from user wein 192.168.0.11 port 55113
debug1: do_cleanup
debug1: do_cleanup
debug1: PAM: cleanup
debug1: PAM: closing session
debug1: PAM: deleting credentials
debug1: audit_event: unhandled event 12
EOF
}
