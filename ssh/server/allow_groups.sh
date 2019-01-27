#!/usr/bin/env bash

# source
# ssh mastery L489

allow_groups() {
    # the server has a group called nogroup
    # only the members of this group are allowed to log in
    AllowGroups nogroup
    
    # client side:
    # this no longer passes UNLESS user wein is added 
    # to the nogroup on the server
    ssh wein@192.168.0.16 
}