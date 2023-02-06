#!/bin/bash

# This script creates a new post in the _posts directory

# Usage: ./make_new_post.sh "Post Title" "file name"
# If no file name is given, the title will be used as the file name

title=$1
file_name=$2

# if no file name is given, use the title as the file name
if [ -z "$file_name" ]; then
    file_name=$title
fi

# lowercase the file name
file_name=$(echo "$file_name" | tr '[:upper:]' '[:lower:]')

# replace spaces with dashes in the file name
file_name_dashed="${file_name// /-}"

# remove any non-alphanumeric characters from the file name
file_name_dashed=$(echo "$file_name_dashed" | tr -cd '[:alnum:]-')

# create the file
path=_posts/$(date +%F)-$file_name_dashed.md
touch "$path"

# write the title to the file
echo "## $title" > "$path"

# add the file to git
git add "$path"

# open the file in nano
nano "$path"
