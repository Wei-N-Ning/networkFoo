#!/usr/bin/env bash
#
# to interact with this server:
# nc localhost 3000
# d
# (show date)
# hell
# (show what?)
# q
# (shutdown server)

coproc nc -l localhost 3000
while read -r cmd
do
    case "$cmd" in
        d) date ;;
        q) kill "$COPROC_PID"
           exit ;;
        *) echo "what?" ;;
    esac
done <&${COPROC[0]} >&${COPROC[1]}
