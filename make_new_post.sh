#!/bin/bash

# This script creates a new post in the _posts directory

# Usage: ./make_new_post.sh "file name" "Post Title"
# If no post title is given, the file name will be used as the title

file_name=$1
title=$2

# if no title is given, use the file name as the title
if [ -z "$title" ]; then
    title=$file_name
fi

# lowercase the file name
file_name=$(echo "$file_name" | tr '[:upper:]' '[:lower:]')

# replace spaces with dashes in the file name
file_name_dashed="${file_name// /-}"

# create the file
path=_posts/$(date +%F)-$file_name_dashed.md
touch "$path"

# write the title to the file
echo "## $title" > "$path"

# add the file to git
git add "$path"

# open the file in nano
nano "$path"
