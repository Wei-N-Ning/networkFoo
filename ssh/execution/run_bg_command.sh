#!/usr/bin/env bash

# source: SSH definitive 2nd P297/317
# 'backgrounding a remote command' take 1
# ssh provides -n command line option to redirect input to come 
# from /dev/null which prevents ssh from blocking for input
# now when the remote command finishes, the output is printed 
# immediately
ssh_run_command_in_bg() {
    ssh -n h6 '/usr/bin/time -vvv sleep 1' &
}

ssh_run_command_in_bg_password() {
    # h8 does not use pubkey authentication therefore prompt me 
    # for password
    # P/318
    # 1. perform auth, including any prompting
    # 2. cause the process to read from /dev/null exactly like -n
    # 3. put the process into bg, no & is needed
    #    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    # go-backgrounding (-f) also set up any port forwarding you 
    # my specified on the command line, the setup occurs after
    # auth but before backgrounding
    ssh -f h8 '/usr/bin/time -vvv sleep 1'
}





