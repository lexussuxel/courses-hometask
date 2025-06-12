#!/bin/bash

function show_file_sizes() {
    if [ -z "$1" ]
    then
        directory="."
    else
        directory="$1"
    fi

    find "$directory" -type f -exec du -h {} \; | sort -rh | awk '{print $2 " - " $1}'
}

show_file_sizes "$1"