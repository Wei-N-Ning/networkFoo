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

# note, I can do it the hard way:
def address_bits(xs):
    """given an IPv4 address as a list of four integers, return its bit-representation"""
    return ' '.join(['{:08b}'.format(x) for x in xs])

print(address_bits([10, 0, 0, 1]))
print(address_bits([10, 0, 0, 212]))
print(address_bits([0b11111111, 0b11111111, 0b11111111, 0b11110000]))

'''
00001010 00000000 00000000 00000001
00001010 00000000 00000000 11010100
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^these bits must be identical or these two
                               addresses are in the same subnet range                              
11111111 11111111 11111111 11110000

'''