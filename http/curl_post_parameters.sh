#!/usr/bin/env bash

# source
# https://ec.haxx.se/http-post.html

# see also
# https://gist.github.com/subfuzion/08c5d85437d5d4f00e58

# firstly, spin up foo server

server="localhost:43333"

# When the data is sent by a browser after data have been filled 
# in a form, it will send it "URL encoded", as a serialized 
# name=value pairs separated with ampersand symbols ('&'). 
# You send such data with curl's -d or --data option like this:
curl -X POST -d 'name=admin&shoesize=12' "${server}/post-foo"

# When specifying multiple -d options on the command line, curl 
# will concatenate them and insert ampersands in between, so 
# the above example could also be made like this:
# NOTE: -X POST is omitted
curl -d 'name=admin' -d 'shoesize=12' "${server}/post-foo"

# If the amount of data to send is not really fit to put in a 
# mere string on the command line, you can also read it off a 
# file name in standard curl style:
# NOTE 
# > the newline character is stripped BUT spaces are preserved!
# > ampersand is still needed (&)

# When reading from a file, -d will strip out carriage return and 
# newlines.
cat <<"EOF" >/var/tmp/sut/params
name=admin
&
password=1111 
XX-213213 
YY-12321 
&
cheat=true
EOF
curl -d '@/var/tmp/sut/params' "${server}/post-foo"

# POSTing with curl's -d option will make it include a default 
# header that looks like 
# Content-Type: application/x-www-form-urlencoded
# { host: 'localhost:43333',
#     'user-agent': 'curl/7.54.0',
#     accept: '*/*',
#     'content-length': '22',
#     'content-type': 'application/x-www-form-urlencoded' }

# explicitly use json for content type
param=$(cat <<"JSON"
{
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  }
}
JSON
)
curl -d "${param}" -H 'Content-Type: application/json' "${server}/post-foo"

# Use --data-binary if you want curl to read and use the given 
# file in binary exactly as given:
dd if=/dev/urandom of=/var/tmp/sut/params bs=128 count=1 2>/dev/null
curl --data-binary '@/var/tmp/sut/params' "${server}/post-foo"

# Convert that to a GET

# A little convenience feature that could be suitable to mention 
# in this context (even though it is not for POSTing), is the -G 
# or --get option, which takes all data you have specified with 
# the different -d variants and appends that data on the right 
# end of the URL separated with a '?' and then makes curl send 
# a GET instead.
curl -G -d 'name=admin' -d 'shoesize=12' "${server}/get-foo"
# example:
# 
# [ '//////// HEADERS ////////',
#   { host: 'localhost:43333',
#     'user-agent': 'curl/7.54.0',
#     accept: '*/*' },
#   '//////// AUTHORIZATION ////////',
#   {},
#   '//////// REQUEST PARAMS (post) ////////',
#   {},
#   '//////// REQUEST QUERY (get) ////////',
#   { name: 'admin', shoesize: '12' } ]
# 
# NOTE:
# the "parameters" for http-get come in the req.query

