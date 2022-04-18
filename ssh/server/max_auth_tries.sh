#!/usr/bin/env bash

# source
# ssh mastery L478

max_auth_tries() {
    # enable these:
    LoginGraceTime 2m
    MaxAuthTries 6
    :
}

use_red_to_defend_DOS() {
    # red against DOS
    MaxStartups 10:30:100
    #           ^^ tries
    #              ^^ 30% chance of rejection
    #                 ^^^ upper threshold
    # if you keep trying during a DOS
    # you will eventually get a winning
    # ticket and be admitted 
}


