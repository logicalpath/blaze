#!/bin/bash

# Check if uuidgen is available
if ! command -v uuidgen &> /dev/null; then
    echo "Error: uuidgen command not found. Please install it."
    exit 1
fi

for file in *; do
    # Skip directories
    if [ -d "$file" ]; then
        continue
    fi

    # Generate a UUID
    uuid=$(uuidgen)

    # Extract the file extension
    ext="${file##*.}"

    # If the filename doesn't have an extension, don't append the dot
    if [[ "$file" == "$ext" ]]; then
        new_name="$uuid"
    else
        new_name="$uuid.$ext"
    fi

    # Rename the file to the UUID
    mv "$file" "$new_name"
done
