#!/usr/bin/env bash

# By Example P162

# connectionless communication (such as UDP) requires no connection to
# be established before communication begins;
# this is like a person with a megaphone shouting to a specific person
# of his choice in a crowd. with each new shout, the person sending
# the message can address his statement to another person without any
# prior agreement.

# after you create a connectionless socket, you will be able to send
# messages to any socket that is willing to receive your messages.
# there will be no connection establishment, and each message can be
# directed to a different receiving socket

# Advantages:
# simpler
# flexible, different recipient each time
# efficient, no setUp or tearDown (avoid overhead)
# fast
# broadcast capability, direct one message to many

# Disadvantage:
# not reliable
# no sequencing of multiple datagrams
# there are message size limitations (can be as low as 512 Bytes)

# a datagram is a unit of data.... it represents one complete message,
# like a telegram



