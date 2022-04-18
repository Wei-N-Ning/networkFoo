#!/usr/bin/env bash

# motivation

# I want to streamline my vim installation script -
# this script should handle:
# git clone or download the payload
# execute the payload
# clean up

# however I stopped half way due to its complexity 

wget_to_stdout() {
    # source
    # https://superuser.com/questions/321240/how-do-you-redirect-wget-to-standard-out/321241

    # download single file from github
    # https://stackoverflow.com/questions/4604663/download-single-files-from-github
    # steps:
    # locate the file,
    # hover mouse on top of "raw" button, pass its url to wget
    # alternativelly I can construct this url from its repo url

    # wget prints some meta info to stderr 
    wget -O - https://github.com/powergun/vimFood/raw/master/inst 2>/dev/null 
    
    # example:
    # wget -O - https://github.com/powergun/vimFood/raw/master/inst 2>/dev/null | bash
    # cat <( wget -O - https://github.com/powergun/vimFood/raw/master/inst 2>/dev/null )
}


