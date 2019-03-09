#!/usr/bin/env bash

# SSH definitive 2nd P/337
preserve_perm() {
    chmod -R 700 /var/tmp/sut
    scp -r -p /var/tmp/sut h6:'~/sut'


    # scp does not duplicate special files and links, so 
    # consider tar or rsync -a instead
}
