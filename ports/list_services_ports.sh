#!/usr/bin/env bash

# warning: result is VERY long!
function run() {
    # NOTE: works on mac
    cat /etc/services | awk '
{ 
    split($2, arr, "/")
    if (length(arr) == 2 && arr[2] != "") {
        print arr[1], arr[2]
    }
} 
'
}

# UPDATE: SSH definitive 2nd P/374
# use POSIX function: getservbyname, getservbyport
# example:
is_service_port() {
    local port_num="${1:?missing port num}"
    perl -MPOSIX -E "say getservbyport(${port_num}, 'tcp');"
}

# UPDATE: SSH definitive 2nd P/374
# avoid using existing service port, use larger number such as 
# 5xxxx
all_service_ports() {
    perl -wnl -E \
'BEGIN{my %ports};
/\b(\d+)\/\w+/ or next; $ports{$1}=1; 
END{$,=","; say sort {$a<=>$b} keys %ports}' \
/etc/services
}

_is_service_port() {
    local port_num="${1:?missing port num}"
    perl -s -w -E \
'chomp(my $text = <>); 
my %ports; $ports{$_}++ foreach(split(/,/, $text));
if (exists($ports{$port_num})) {
    say "is service";
}
else {
    say "not service";
}' -- -port_num="${port_num}" \
<(all_service_ports)
}

is_service_port "$1"
