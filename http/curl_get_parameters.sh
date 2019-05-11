#!/usr/bin/env bash

# see also:
# http://conqueringthecommandline.com/book/curl

# firstly, spin up foo server

server="localhost:43333"

# taking advantage of curl's -G transformation feature
curl -s -G -d "map=atthehellsgate" -d 'code=e1m1' "${server}/get-foo" >/dev/null

# use curl's awesome urlencode feature to escape all the characters
curl -s -G \
--data-urlencode "map=at the hell's gate" \
--data-urlencode "code='set e1m1 = 1337'" \
"${server}/get-foo" >/dev/null

