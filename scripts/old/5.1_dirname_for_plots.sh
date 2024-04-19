#!/bin/bash

# Function to rename PNG files in subdirectories
rename_png_files() {
    local dir="$1"
    local subdir
    local png_file

    for subdir in "$dir"/*; do
        if [ -d "$subdir" ]; then
            rename_png_files "$subdir"  # Recursively call function for subdirectory
            subdir_name=$(basename "$subdir")
            # Rename PNG files within the subdirectory
            for png_file in "$subdir"/*.png; do
                if [ -f "$png_file" ]; then
                    mv "$png_file" "$subdir"/"${subdir_name}_${png_file##*/}"
                fi
            done
        fi
    done
}

# Directory path
#dir_path="/path/to/parent/directory"
#
## Start recursion from the parent directory
#rename_png_files "$dir_path"
#
## Loop through subdirectories
#for subdir in "$dir_path"/*; do
#    if [ -d "$subdir" ]; then
#        subdir_name=$(basename "$subdir")
#        # Rename PNG files within the subdirectory
#        for png_file in "$subdir"/*.png; do
#            if [ -f "$png_file" ]; then
#                mv "$png_file" "$subdir"/"${subdir_name}_${png_file##*/}"
#            fi
#        done
#    fi
#done

# Find PNG files and move them to a new file with the subdir name appended
#find "$dir_path" -type f -name "*.png" -exec sh -c 'mv "$0" "$(dirname "$0")/$(basename "$(dirname "$0")")_$(basename "$0")"' {} \;
