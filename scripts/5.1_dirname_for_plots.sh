#!/bin/bash

#
#

if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory path to samples>"
    exit 1
fi

dir="$1"
png=$(find "$dir" -type f -name "graph*.png" )

echo $png
