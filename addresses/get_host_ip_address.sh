#!/usr/bin/env bash
# source
# https://www.youtube.com/watch?v=l0QGLMwR-lY

show_ip_address() {
    # arg optional
    # ip is considered better than ifconfig, which is older 
    ip addr show 

    ifconfig
}

