#!/usr/bin/env python3

# This script is used to make a new post credit scene post for the blog.

# Accept a single argument, the body containing the post data.
# The body should be in the following format:
#   <movie_name>
#   <year>
#   <yes_or_no>
#   <tags>

# The script will then create a new post credit scene post with the given data.

import sys
from datetime import datetime

# Get the body from the command line argument.
body = sys.argv[1]

# Get the movie name from the body.
movie_name = body.split('\n')[0].strip()
year = body.split('\n')[1].strip()
yes_or_no = body.split('\n')[2].strip()
tags = body.split('\n')[3]  # comma separated list of tags
tags = tags.split(',')
tags = [tag.strip() for tag in tags]

DEFAULT_TAGS = [
    "post-credit",
    "post-credits",
    "scene",
    "scenes",
    "movie",
    "theatre",
    "theater",
    "cinema",
    "film",
    "spoiler",
    "spoilers"
]

# Combine tags and default tags.
tags = tags + DEFAULT_TAGS
# Add movie name as a tag.
tags.append(movie_name)
# Remove duplicates.
tags = list(set(tags))

# Format tags for the post.
tags_formatted = '\n    - '.join(tags)

# Build post title
post_title = f"Does {movie_name} ({year}) have a post credit scene?"

# Build yes or no answer
yes_or_no_answer = "Yes." if yes_or_no.lower().startswith('y') else "No."

# Today's date in YYYY-MM-DD format
today = datetime.today().strftime('%Y-%m-%d')

# Build file name, based on post title
file_name = post_title
# Lowercase the file name
file_name = file_name.lower()
# Replace spaces with dashes
file_name = file_name.replace(' ', '-')
# Remove any non-alphanumeric characters
file_name = ''.join(c for c in file_name if (c.isalnum() or c == '-'))
# Remove any trailing dashes
file_name = file_name.rstrip('-')
# Add MD extension
file_name = f"{today}-{file_name}.md"

# Build the post body
post_body = f"""---
description: {post_title}
tags: 
    - {tags_formatted}
---

## {post_title}

{yes_or_no_answer}
"""

# Create the file in the _posts directory.
with open(f"_posts/{file_name}", 'w') as f:
    f.write(post_body)

print(f"Created post: {file_name}")

