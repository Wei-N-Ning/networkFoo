# Acknowledgment number

read: multiplayer game development P/43

> acknowledgment number (32bit) contains the sequence number of the
next byte of data that the sender is expecting to receive.

 This acts as a de facto acknowledgment for all
data with sequence numbers lower than this number: Because TCP guarantees all data is
delivered in order, the sequence number of the next byte that a host expects to receive is
always one more than the sequence number of the previous byte that it has received.

Be careful to remember that the sender of this number is not actually acknowledging receipt
of the sequence number with this value, but actually of all sequence numbers lower than
this value.
