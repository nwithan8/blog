#!/bin/bash

# This script creates a new post-credit post in the _posts directory

# Usage: ./make_new_post.sh "Movie Name" Year "Y/N" "additional" "metadata" "tags"

# show help if no arguments are given
if [ -z "$3" ]; then
    echo "Usage: ./make_new_post_credit_post.sh \"Movie Name\" Year \"Y/N\" \"additional\" \"metadata\" \"tags\""
    exit 1
fi

movie=$1
year=$2
yesno=$3

standard_tags=("$movie" "post-credit" "post-credits" "scene" "scenes" "movie" "theatre" "theater" "cinema" "film" "spoiler" "spoilers")

# Capture 4th argument through the end
for i in "${@:3:$#-5}"
do something with "$i"
done

title="Does $movie ($year) have a post-credits scene?"
file_name=$title

# lowercase the file name
file_name=$(echo "$file_name" | tr '[:upper:]' '[:lower:]')

# replace spaces with dashes in the file name
file_name_dashed="${file_name// /-}"

# remove any non-alphanumeric characters from the file name
file_name_dashed=$(echo "$file_name_dashed" | tr -cd '[:alnum:]-')

# create the file
path=_posts/$(date +%F)-$file_name_dashed.md
touch "$path"

# write the metadata to the file
echo "---" > "$path"
echo "description: $title" >> "$path"
echo "tags:" >> "$path"
for i in "${standard_tags[@]}"
  do echo "  - $i" >> "$path"
done
for i in "${@:3:$#}"
  do echo "  - $i" >> "$path"
done
echo "---" >> "$path"
echo "" >> "$path"

# write the title to the file
echo "## $title" >> "$path"
echo "" >> "$path"

# write the body to the file
body="No."
if [ "$yesno" == "Y" ]; then
    body="Yes."
fi
echo "$body" >> "$path"

# add the file to git
git add "$path"

# open the file in nano
nano "$path"
