#!/bin/sh

whoami

echo "called from /etc/ssh/sshrc" >>/var/tmp/fool

# //// read this ////
# /etc/ssh/sshrc and ~/.ssh/rc are mutual exclusive

# http://manpages.ubuntu.com/manpages/bionic/man8/sshd.8.html#sshrc

# If this file (~/.ssh/rc) does not exist, /etc/ssh/sshrc is run, 
# and if that does not exist either, xauth is used to add the cookie.

# install etc rc script
# sudo ln -s /Users/wein/work/dev/playground/github.com/powergun/networkfoo/ssh/server/etc_ssh_sshrc.sh /etc/ssh/sshrc

# install home rc script
# ln -s /Users/wein/work/dev/playground/github.com/powergun/networkfoo/ssh/server/home_ssh_rc.sh ~/.ssh/rc

# uninstall rc scripts
# sudo rm -f /etc/ssh/sshrc ~/.ssh/rc