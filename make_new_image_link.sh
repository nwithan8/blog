#!/bin/bash

# This script creates a new remote image link for a local image file

# Usage: ./make_new_image_link.sh file_path

GITHUB_BASE=https://raw.githubusercontent.com/nwithan8/blog/master/

# show help if no arguments are given
if [ -z "$1" ]; then
    echo "Usage: ./make_new_image_link.sh file_path"
    exit 1
fi

file_path=$1

# get absolute path of this file
file_path=$(realpath $file_path)

# get absolute path of this script
script_path=$(dirname $(realpath $0))

# if file_path does not contain script_path, then file_path is not a child of script_path
if [[ ! $file_path == *$script_path* ]]; then
    echo "Error: file must in the same directory or a child directory of this script"
    exit 1
fi

# get the relative path of the file
file_path_relative=${file_path#$script_path}

# replace spaces with %20
file_path_relative=${file_path_relative// /%20}

# remove leading / from file_path if it exists
file_path_relative=${file_path_relative#/}

# print the link
echo $GITHUB_BASE$file_path_relative
