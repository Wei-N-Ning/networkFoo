#!/usr/bin/env bash

# source
# https://gist.github.com/htp/fbce19069187ec1cc486b594104f01d0

# motivation:
# websocket basic concept; how to communicate

curl_websocket() {
    curl --include \
        --no-buffer \
        --header "Connection: Upgrade" \
        --header "Upgrade: websocket" \
        --header "Host: example.com:80" \
        --header "Origin: http://example.com:80" \
        --header "Sec-WebSocket-Key: SGVsbG8sIHdvcmxkIQ==" \
        --header "Sec-WebSocket-Version: 13" \
        http://example.com:80/
}