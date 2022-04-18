#!/usr/bin/env bash

# tracepath does not require root priv

: <<"EXAMPLE"
 1?: [LOCALHOST]                      pmtu 1500
 1:  192.168.1.1                                           2.265ms 
 1:  192.168.1.1                                           1.607ms 
 2:  192.168.1.1                                           1.339ms pmtu 1480
 2:  10.20.25.120                                          8.305ms 
 3:  203.29.134.61                                         8.950ms 
 4:  no reply
 5:  no reply
 6:  no reply

EXAMPLE
