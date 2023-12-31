#!/bin/bash

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo -e "
Usage: ./upload_dir.sh [directory]

Description:
  Lists and uploads files from the specified directory (or the current directory if none is specified) to a Backblaze B2 bucket.

Arguments:
  directory  - The directory of files you want to upload. If not provided, the current directory is used.

Environment Variables:
  B2_BUCKET_NAME - The name of the B2 bucket where files will be uploaded. Must be set before running the script.
"
  exit 0
fi


# b2 bucket name
b2_bucket_name="${B2_BUCKET_NAME}"

# Get the directory to list, either the provided subdirectory or the current directory
dir_to_list="${1:-.}"

# Ensure the directory exists
if [[ ! -d "$dir_to_list" ]]; then
    echo "Error: $dir_to_list is not a valid directory."
    exit 1
fi

# Get the name of the subdirectory
subdir_name=$(basename "$dir_to_list")



# Get the absolute path of the directory to list without the subdirectory name
abs_dir_path=$(cd "$dir_to_list" && cd .. && pwd)

# Get the list of files in the directory
for file in "$dir_to_list"/*; do
    # Check if it's a file (and not a directory)
    if [[ -f "$file" ]]; then
        # Print "subdir_name"/filename
        # b2_filename="\"$subdir_name\"/$(basename "$file")"
        b2_filename="$subdir_name/$(basename "$file")"

        echo "b2_filename: $b2_filename"
        # Print full path of the file with escaped space
        local_filename="$abs_dir_path/$subdir_name/$(basename "$file")"
        echo "local_filename: $local_filename"

        # Upload the file to B2
        echo "b2 upload-file "$b2_bucket_name" "$local_filename" "$b2_filename""
        b2 upload-file "$b2_bucket_name" "$local_filename" "$b2_filename"

        echo "-----------------------------"
    fi
done

