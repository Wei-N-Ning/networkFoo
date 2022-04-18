#!/usr/bin/env bash

# from ssn man page:
# -G      
# Causes ssh to print its configuration after evaluating 
# Host and Match blocks and exit.

# can be quite useful for debugging

show_host_conf() {
    ssh -G 'github.com'
}





