#!/usr/bin/env bash

# see also:
# https://github.com/trimstray/test-your-sysadmin-skills#simple-questions
# who
# w
# last

: <<TEXT
For a summary of logged-in users, including each login of a username,
the terminal users are attached to, the date/time they logged in,
and possibly the computer from which they are making the connection,
enter:

# It uses /var/run/utmp and /var/log/wtmp files to get the details.
who

For extensive information, including username, terminal, IP number
of the source computer, the time the login began, any idle time,
process CPU cycles, job CPU cycles, and the currently running 
command, enter:

# It uses /var/run/utmp, and their processes /proc.
w

Also important for displays a list of last logged in users, enter:

# It uses /var/log/wtmp.
last
TEXT

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
