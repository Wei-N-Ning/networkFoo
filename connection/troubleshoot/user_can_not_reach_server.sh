#!/usr/bin/env bash

# person can not reach x.y.z

# ========== isolation & questionnaire approach ================

# can I reach x.y.z? is it reproducible?
# ask the person to ping another neighbouring server

# if I can repro
# try ip address not domain name
# ip addr is working ==> troubleshoot DNS

# if can not connect even with IP address
# check the management console (aws, ec2, etc..)
# health stats? up and running? 

# if it is running
# ssh to it
# check the status of httpd/nginx/apache
# sar
# restart the server if needed

# check uptime (and load average)
# check whether it was reboot recently? what had changed?
# check /var/log (loggly etc.)

# check iptables, ufw (aws security group, NACL)

# not able to ssh to it?
# look at the logs (loggly, ec2 log, access log)

# as the last resort, hard reboot or even re-provision 
# (not too difficult with infrastructure as code, like terraform)

# do I have a backup? failover?
