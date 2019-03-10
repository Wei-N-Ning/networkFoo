#!/usr/bin/env perl

=pod

https://unix.stackexchange.com/questions/55913/whats-the-easiest-way-to-find-an-unused-local-port
python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()'

=cut

use warnings FATAL => 'all';
use strict;
use 5.010;

use Socket;
use Socket qw( sockaddr_in );

sub get_free_port {
    # source
    # https://www.perlmonks.org/?node_id=579649
    my $proto = getprotobyname("tcp");
    socket(my $socket, PF_INET, SOCK_STREAM, $proto) or die;
    bind($socket, sockaddr_in(0, INADDR_ANY)) or die;
    my $port = (sockaddr_in(getsockname($socket)))[0];
    say $port;
}

get_free_port();
