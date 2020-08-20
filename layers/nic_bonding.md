# NIC bonding

source: <https://www.webopedia.com/TERM/N/NIC_bonding.html>

<https://en.wikipedia.org/wiki/Link_aggregation>

provide fail-over, redundancy, and may increase bandwidth (1G + 1G = 2G)

## configuration

firstly the nic driver must exist;

secondly two nics exist;

eth0 + eth1; /etc/network, one master file and one slave file

systemctl to restart to make the bonding effective
