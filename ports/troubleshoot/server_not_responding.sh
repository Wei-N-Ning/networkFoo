#!/usr/bin/env bash

# server is not responding

# is server listening to its port(s)?
check_ports_listening() {
    netstats -lnp "$(pgrep server_executable)"
}
