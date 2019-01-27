#!/usr/bin/env bash

# source: SSH Mastery L298

nc_query() {
    # example:
    # login on u18 vbox and run:
    nc -v localhost 22
    
    # returns:
    # SSH-2.0-OpenSSH_7.6p1 Ubuntu-4ubuntu0.1
    # ssh version, provider's information (open ssh 7.6p1)

    # ps aux | grep -i sshd
    # root       728  0.0  0.2  72296  5636 ?        Ss   22:42   0:00 /usr/sbin/sshd -D
    # root       912  0.1  0.3 107984  7212 ?        Ss   22:47   0:00 sshd: wein [priv]
    # wein      1040  0.1  0.1 107984  3592 ?        S    22:47   0:00 sshd: wein@pts/0

    # this shows sshd is running with privilege seggregation
    # 912: priviledged process that handles my ssh connection into this host
    # 1040: unpriviledged process that handles my login session

    # on mac the sshd is by default not running,
    # unless turned on in Sharing dialog
}


