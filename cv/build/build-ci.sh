#!/bin/bash

set -e

export SOURCE_DIR="../src"
export DESTINATION_DIR=".."

md_timestamp=$(git log -1 --format=%ct $SOURCE_DIR/cv.md)
pdf_timestamp=$(git log -1 --format=%ct $DESTINATION_DIR/cv.pdf)


if [ $md_timestamp -gt $pdf_timestamp ]; then
    echo "Generating new PDF..."
    npm ci
    npm run build -- --debug
    git add $DESTINATION_DIR/cv.pdf $DESTINATION_DIR/cv.html
    git commit -m "github actions generated PDF and HTML on $(date +%Y-%m-%dT%H:%M:%S)"
    git push origin HEAD:master
else
    echo "cv.pdf is up to date with cv.md, no action needed"
    exit 0
fi
