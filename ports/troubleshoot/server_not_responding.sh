#!/usr/bin/env bash

# server is not responding

# is server listening to its port(s)?
# also run systemctl status <service name> to check its status
check_ports_listening() {
    netstats -lnp "$(pgrep server_executable)"
}
