# Sequence Number

read: multiplayer game development P/43

> each byte transferred via TCP has a consecutive sequence number
which serves as a unique identifier of that byte.
> the sequence number of a segment is typically the sequence number
of the first byte of data in that segment.

## What happens when sequence number reaches the max

read: <https://stackoverflow.com/questions/2672734/tcp-sequence-number-question>

> TCP sequence numbers and receive windows behave very much like a clock.
The receive window shifts each time the receiver receives and acknowledges
a new segment of data. Once it runs out of sequence numbers, the sequence
 number loops back to 0.

Also see chapter 4 of RFC 1323.
