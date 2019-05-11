#!/usr/bin/env bash

thisdir=$(dirname "$0")
PORT=43333 node --experimental-modules "${thisdir}/server.mjs"
