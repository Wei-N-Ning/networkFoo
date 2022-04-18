#!/usr/bin/env bash

howto_simulate_network_issue() {
: <<"TEXT"
iptables
iptables -A INPUT -m statistic --mode random --probability 0.1 -j DROP
iptables -A OUTPUT -m statistic --mode random -probability 0-.1 -j DROP

tc
tc qdisc add dev eth0 root netem delay 50ms 20ms distribution normal
tc qdisc change dev eth0 root netem reorder 0.02 duplicate 0.05 corrupt
TEXT
}
