#!/usr/bin/env bash

# SSH definitive 2nd P/316
# tty is a software abstraction representing a computer terminal,
# abbreviation for teletype 
# 
# as part of an interactive session with a unix machine, a tty is 
# allocated to process keyboard input, limit screen output to a given 
# number of rows and columns, and handle other terminal-related 
# activities 

# since most terminal-like connections don't involve an actual hardware
# terminal, but rather a window, a software construct called a 
# pseudo-tty (pty) handles this sort of connection

# when a client requests a ssh connection, the server does not necessarily 
# allocate a pty for the client.
# it does so if the client requests an interactive terminal session
# if you ask ssh to run a simple command, no interactive terminal session
# is needed, just a quick dump of the output 
# if you try running an interactive command likst vi you get an 
# error message:

# standard input is not a tty

# you can request that ssh allocate a pty using -t option
# ssh -t hostname prog
allocate_pty() {
    ssh -t -F ~/.ssh/dev.jump.config dev.jump vi

    # if SSH allocates a pty it also automatically defines an env var
    # in the remote shell
    echo "${SSH_TTY}"
    # /dev/pts/0
    # the name of the character device file connected to the slave 
    # side of the pty, the side that emulates a real tty

    # spam to all pty devices
    find /dev/pts | perl -wnl -E '/\/\d+$/ and `echo "terminate!" >$_`'
}

