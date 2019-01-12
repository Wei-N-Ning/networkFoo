#!/usr/bin/env bash

set -euo pipefail

run_single_command() {
    # service
    ssh ubuntu@54.252.141.241 -i ./mortalenginex2.enc "df -h" | \
        # filter
        perl -lane '@F[5] =~ /\/$/ && print $_'

        # chain to other services...
}

run_single_command
