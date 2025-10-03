#!/bin/bash

set -e

pdf_timestamp=$(git log -1 --format=%ct cv.pdf)
md_timestamp=$(git log -1 --format=%ct cv.md)

if [ $md_timestamp -gt $pdf_timestamp ]; then
    echo "Generating new PDF..."
    npm ci
    npm run build -- --debug
    git add cv.pdf cv.html
    git commit -m "github actions generated PDF and HTML on $(date +%Y-%m-%dT%H:%M:%S)"
    git push origin HEAD:master
else
    echo "cv.pdf is up to date with cv.md, no action needed"
    exit 0
fi
