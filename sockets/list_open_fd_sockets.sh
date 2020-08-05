#!/usr/bin/env bash

list_open_fds_from_program() {
    # -n       inhibits the conversion of network numbers to host
    #          names for network files.  Inhibiting conversion may
    #           make lsof run faster.  It is also useful when host
    #           name lookup  is not working properly
    # -p  for <pid> only
    # -i [i]   selects the listing of files any of whose Internet 
    #          address matches the address specified in i.  If no
    #          address is specified, this option selects the listing
    #          of all Internet and x.25 (HP-UX) network files
    # -P       inhibits the conversion of port numbers to port names
    #          for network files.  Inhibiting the conversion may 
    #          make lsof run a little faster.  It is also useful 
    #          when port  name lookup is not working properly.

    lsof -i -n -P -p "$(pgrep konsole)"
}
