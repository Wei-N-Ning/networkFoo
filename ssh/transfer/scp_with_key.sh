#!/usr/bin/env bash

copy_file_to_server() {
    # note -i keyfile is precedes other arguments
    # the target path is encapsulated in '' to allow later substitution
    # (otherwise $USER is substituted client side)
    scp -i keyfile srcfile user@...:'${USER}/asd'
}

copy_dir_toserver() {
    scp -i keyfile -r dirpath user@...:'${USER}/asd'
}
