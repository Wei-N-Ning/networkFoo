#!/usr/bin/env bash

# source SSH definitive 2nd P139/160

ps aux | perl -wnl -E '/^root/ and /sshd/ and say'

kill -HUP '<pid>'


# but it's better to do it via init.d/systemctl
sudo systemctl restart sshd

# P/161

# sshd -p 3333

# The server uses TCP port 3333.
# Now, suppose you restart sshd with SIGHUP:

# $ kill -HUP `pidof sshd`

# forcing sshd to reread the configuration file. What do you 
# think happens to the port
# number? Does the server use port 2222 after rereading the 
# configuration file, or does
# the command-line option remain in effect for port 3333? In 
# fact, the command-line
# option takes precedence again, so port 3333 is reused. sshd 
# saves its argument vector * and reapplies it on restart.



