#!/usr/bin/env bash

# source:
# https://askubuntu.com/questions/95676/a-tool-to-measure-signal-strength-of-wireless

watch -n1 iwconfig
# look for "Link Quality" and "Signal level" values.

