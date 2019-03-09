#!/usr/bin/env bash

# SSH definitive 2nd P/349
anatomy_authorization_file() {
    : <<"TEXT"
from="host.address" ssh-rsa "public key" "comment"
a set of opts         type    value        comment

multiple options may be given together, separate by commas, with
no whitespace between the options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

options provide extra security and convenience
TEXT
}

forced_commands() {
    : <<"TEXT"
a forced command... instead of the client deciding which command 
will run, the owner of the server account decides 
the client has requested the command /bin/ls but the server-side
forced command runs /bin/who instead

command="/usr/bin/who" ssh-rsa ....

NOTE: THIS CAN PERMENANTLY DISABLE TERMINAL-BASED LOGIN !!
Leave a backdoor there!!! 
TEXT
}

access_control() {
    # SSH definitive 2nd P/359
    : <<"TEXT"
from="hostname" ...key...
enforces that any SSH connection must come from hostname, or else 
it is rejected. 
it is the same ACL provided by AllowUsers keyword for serverwide 
configuration.

test on h6 bastion
1. disable sshd_config PasswordAuthentication (set to no)
2. from="192.168.0.*"
login is still fine because my address is 192.168.05

3. change to from="192.168.0.99"
can not login anymore 
wein@192.168.0.6: Permission denied (publickey).

to make this restriction serverwide:
modify sshd_config, adding
AllowUsers 192.168.0.*
serverwide setting takes precedence, if the system admin had denied
this access using DenyUsers keyword, then user can't override this 
restriction using the from option...

there can be also be multiple patterns, separated by commas
(AllowUsers/DenyUsers uses spaces)
from="!saruman.ring.org,*.ring.org"
TEXT
}
