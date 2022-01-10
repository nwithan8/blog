#!/bin/bash
title=$1
title_underscore="${title// /-}"
path=_posts/$(date +%F)-$title_underscore.md
touch $path
echo "## $title" > $path
nano $path
