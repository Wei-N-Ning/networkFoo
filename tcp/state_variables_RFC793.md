# TCP state variables RFC 793

## Send Next, SND.NXT

The sequence number of the next segment the host will send

## Send Unacknowledged, SND.UNA

The sequence number of the oldest byte sent by the host that has not yet been acknowledged

## Send Window, SND.WND

The current amount of data the host is allowed to send before receiving an acknowledgment
for unacknowledged data

## Receive Next, RCV.NXT

The next sequence number the host expects to receive

## Receive Window, RCV.WND

The current amount of data the host is able to receive without overflowing its receive buffer

Read: multiplayer game programming P/49

TCP flow control.
