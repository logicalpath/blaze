#!/bin/bash

# Get the directory to list, either the provided subdirectory or the current directory
dir_to_list="${1:-.}"

# Ensure the directory exists
if [[ ! -d "$dir_to_list" ]]; then
    echo "Error: $dir_to_list is not a valid directory."
    exit 1
fi

# Get the name of the subdirectory
subdir_name=$(basename "$dir_to_list")

# Get the list of files in the directory
for file in "$dir_to_list"/*; do
    # Check if it's a file (and not a directory)
    if [[ -f "$file" ]]; then
        echo "$subdir_name/$(basename "$file")"
    fi
done
