#!/usr/bin/env bash

# SSH definitive P26/46

copy_pubkey_to_host() {
    ssh-copy-id -i key_file user@host
}