#!/usr/bin/env bash

# source: SSH definitive 2nd P227/247
# an ssh identity is a sequence of bits that says: I am really me, 
# it is a mathematical construct that permits an ssh client to prove 
# itself to an ssh server, so the ssh servers: ah I see it is really 
# you. You are hereby authenticated. Come in.

# the client uses private key the prove your identity to the server

# you may have as many ssh identities as you like.
# most ssh implementations let you specify a default identity clients
# use unless told otherwise
# to use an alternative identity you must change a setting by command 
# line argument, configuration file or some other configuration tool.

generate_openssh_keys() {
    # by default -b (num bits) is 1024
    # -N '' to disable password (for automation, but bad for security); 
    # -N '<password>' to hardcode a password (bad bad bad)
    # -C 'comment text'; by default the comment is username@host
    ssh-keygen -t '<type_name>' -b 2048 -f 'filename'

    # in addition to creating keys, ssh-keygen can manipulate existing 
    # keys (-p switch)
    # it does not change the key so the correpsonding pubkey
    # on remote machines does not need to be replaced
    ssh-keygen -t rsa -p -f 'filename' -P 'curr_secret' -N 'new_secret'
    # or to use the prompt
    ssh-keygen -t rsa -p -f 'filename'
}

print_key_fingerprint() {
    # SSH definitive 2nd P/255
    # see also man ssh-keygen
    # the fingerprint can be calculated from the public key
    ssh-keygen -l -f 'filename'
    # Show fingerprint
    # 2048 SHA256:agJ0d0+AyhCeHmb/ddfs3oq+lVprR5pvVD6X4kgkz54 weining@MacBook-Pro-8.local (RSA)
    ssh-keygen -B -f 'filename'
    # Show the bubblebabble digest
    # 2048 xitif-syban-vohuh-latum-hyhyz-rusot-dogim-farer-poton-typec-coxux weining@MacBook-Pro-8.local (RSA)
    ssh-keygen -l -v -f 'filename'
    # show ascii art!

    # compare the rsa fingerprint against the record in ssh-agent
    ssh-add 'filename'
    ssh-add -l
    # they should look identical
}


