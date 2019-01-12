#!/usr/bin/env bash

set -euo pipefail

run_single_command() {
    # service
    ssh wein@192.168.0.15 "df -h" | \
        # filter
        perl -lane '@F[5] =~ /\/$/ && print $_'

        # chain to other services...
}

run_single_command
