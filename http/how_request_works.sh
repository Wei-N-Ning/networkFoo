#!/usr/bin/env bash

# source:
# how a web request works down to the atom talk

: '
http://assets.imgix.net/examples/treefrog?w=400
protocol
        network location 
                        path and query

the browser builds an HTTP request out of the url

GET /examples/treefrog?w=400 HTTP/1.1
# path and query               protocl
Host: assets.imgix.net
# network location
User-Agent: curl/7.54.0
Accept: image/webp,*/*
Accept-Encoding: br,gzip,deflat
'
