# TCP three ways handshake

## Why bother using three ways handshake, not 2-ways

source: <https://networkengineering.stackexchange.com/questions/24068/why-do-we-need-a-3-way-handshake-why-not-just-2-way>

> So to come back to your question, why not just use a two-way
> handshake? The short answer is because a two way handshake
> would only allow one party to establish an ISN, and the other
> party to acknowledge it. Which means only one party can send data.
> But TCP is a bi-directional communication protocol, which means
> either end ought to be able to send data reliably. Both parties
> need to establish an ISN, and both parties need to acknowledge
> the other's ISN.
