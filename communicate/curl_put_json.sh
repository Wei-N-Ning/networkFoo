#!/usr/bin/env bash

# --header '<set key-values>'
# -d '<stringified json>'
curl -X PUT --header 'content-type: application/json' -v 'http://0.0.0.0:8000/README.md' -d '{"a": "b"}'

# data is stored in the body section
