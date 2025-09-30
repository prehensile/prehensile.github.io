#!/bin/bash

set -e

pdf_timestamp=$(git log -1 --format=%ct cv.pdf)
md_timestamp=$(git log -1 --format=%ct cv.md)

echo $pdf_timestamp
echo $md_timestamp

if [ $md_timestamp -gt $pdf_timestamp ]; then
    echo "Generating new PDF..."
    npm ci
    npm run build
    git add cv.pdf
    git commit -m "github actions generated PDF on $(date +%Y-%m-%dT%H:%M:%S)"
    git fetch origin master
    git push origin HEAD:master
else
    echo "cv.pdf is up to date with cv.md, no action needed"
    exit 0
fi
