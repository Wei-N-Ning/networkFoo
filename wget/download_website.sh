#!/usr/bin/env bash

# source:
# https://www.linuxjournal.com/content/downloading-entire-web-site-wget

# The options are:

# --recursive: download the entire Web site.

# --domains website.org: don't follow links outside website.org.

# --no-parent: don't follow links outside the directory tutorials/html/.

# --page-requisites: get all the elements that compose the page (images, CSS and so on).

# --html-extension: save files with the .html extension.

# --convert-links: convert links so that they work locally, off-line.

# --restrict-file-names=windows: modify filenames so that they will work in Windows as well.

# --no-clobber: don't overwrite any existing files (used in case the download is interrupted and resumed).

download() {
    # www.website.org/tutorials/html/
    local url="${1:?missing url}"
    # website.org
    local domains="${2:?missing domains}"
    local target_dir="${3:-.}"
    wget \
        --recursive \
        --no-clobber \
        --page-requisites \
        --html-extension \
        --convert-links \
        --restrict-file-names=windows \
        --domains "${domains}" \
        --no-parent \
        -P "${target_dir}" \
        "${url}"
}

# example:
# bash download_website.sh https://theswissbay.ch/pdf/Politics/USA/ theswissbay.ch /tmp/sut
download $@
