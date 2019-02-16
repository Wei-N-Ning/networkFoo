#!/usr/bin/env bash

# NOT WORKING ON MAC!

# stderr: noises
netstat -nepal 2>/dev/null | grep -i 22

# only tcp
netstat -nepal -t 2>/dev/null | grep -i 22

netstat -lnp 2>/dev/null
# will list the pid and process name next to each
# listening port. This will work under Linux,
# but not all others (like AIX.)
# Add -t if you want TCP only.

# source
# https://www.youtube.com/watch?v=l0QGLMwR-lY
# mnemonic: [tulpin] 
# to see ALL the program names:
# sudo netstat -tulpn 
netstat -tulpn

# 
lsof -i tcp:80

# source
# https://www.cyberciti.biz/faq/what-process-has-open-linux-port/
fuser 7000/tcp 2>/dev/null

