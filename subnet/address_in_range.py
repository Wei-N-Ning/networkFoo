#!/usr/bin/env python3
# require python3.8+

# Python3.8+ has an awesome built-in ipaddress utility library
# 
# source:
# https://docs.python.org/3/library/ipaddress.html
# also read:
# https://docs.python.org/3/howto/ipaddress.html

# inspired by: network for web developer talk
# the host has to write a php function to demonstrate this
# concept

import ipaddress

addr = ipaddress.ip_address('10.0.0.1')
rang = ipaddress.ip_network('10.0.0.0/28')


assert addr in rang

assert ipaddress.ip_address('10.0.0.212') not in rang