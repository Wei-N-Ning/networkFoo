#!/usr/bin/env bash

# source
# linux socket by example P74 and sys/un.h
# I'm interested to see how SUN_LEN works,
#   0x00000000004005bc <+38>:	48 8d 45 80	lea    rax,[rbp-0x80]
#   0x00000000004005c0 <+42>:	48 83 c0 02	add    rax,0x2
#   0x00000000004005c4 <+46>:	48 89 c7	mov    rdi,rax
#   0x00000000004005c7 <+49>:	e8 94 fe ff ff	call   0x400460 <strlen@plt>
#   0x00000000004005cc <+54>:	48 83 c0 02	add    rax,0x2
# as shown above, the compiler (gcc) figures out that
# the length of the first field (address family) is 2 bytes,
# therefore this statement in the macro:
#  (size_t) ( ((struct sockaddr_un *) 0)->sun_path )
# is just to announce that this length value is to be used by
# the subsequent operation

setUp() {
    set -e
    rm -rf /tmp/sut
    mkdir /tmp/sut
    PATH=${PATH}:$( dirname ${0} )/../utilities
}

buildProgram() {
    cat > /tmp/sut/_.c <<EOF
#include <unistd.h>
#include <sys/un.h>
int main() {
    struct sockaddr_un adr_unix;
    adr_unix.sun_path[0] = 'a';
    adr_unix.sun_path[1] = 'b';
    adr_unix.sun_path[2] = '\0';

    // part 1: ((struct sockaddr_un *) 0)->sun_path
    // convert the result to size_t
    // part 2: strlen ((ptr)->sun_path))
    size_t l = SUN_LEN(&adr_unix);
    if (l) {
        return 0;
    }
    return 1;
}
EOF
}

setUp
buildProgram
ticc dasm /tmp/sut/_.c
