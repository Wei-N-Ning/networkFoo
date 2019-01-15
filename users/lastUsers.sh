#!/usr/bin/env bash

showLastLoggedOnUsers() {
    last -a
}

show_users_that_are_not() {
    # this is an example of showing any entries not starting with 
    # username "weining" on CA's macbook pro
    # recall the unless modifier 
    last | perl -lane 'print $_ unless @F[0] =~ /^weining/'
}

showLastLoggedOnUsers
