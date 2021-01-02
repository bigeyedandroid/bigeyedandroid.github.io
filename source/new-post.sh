#!/bin/bash

ROOT_DIR=$(git rev-parse --show-toplevel)
cd $ROOT_DIR/source

getPostTitle() {
    read -p "Enter Post title (Ctrl-C to cancel): " POST_TITLE
    POST_SLUG=$(echo $POST_TITLE| tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -dc '[:alnum:]\n\r-')
    if [[ "$POST_TITLE" == "" || "$POST_SLUG" == "" ]]; then
        echo "Invalid post title."
        getPostTitle
    fi
}

getPostTitle

if [ -d "$PWD/content/posts/$POST_SLUG" ]; then
    echo "Post with same slug exists."
    exit 2
fi

mkdir -p content/posts/$POST_SLUG/images
touch content/posts/$POST_SLUG/{_,}index.md
FILE=$ROOT_DIR/source/content/posts/$POST_SLUG/index.md
open -a "Sublime Text.app" $ROOT_DIR/source/
open -a "Sublime Text.app" $FILE
cat <<EOF > content/posts/$POST_SLUG/index.md
---
title: $POST_TITLE
date: $(date "+%Y-%m-%dT%H:%M:%S%z")
draft: false
tags:
  - TAG_1
  - TAG_2
---
EOF

echo "Open $ROOT_DIR/source/content/posts/$POST_SLUG/index.md and add markdown content."

hugo server -D &

open http://localhost:1313

wait `jobs -p`