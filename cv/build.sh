#!/bin/bash

set -e

# Check if cv.pdf needs regeneration by comparing file hashes or modification times
if git diff --quiet HEAD -- cv.md; then
    echo "cv.md unchanged in this commit, no action needed"
    exit 0
fi

echo "Generating new PDF..."
npm ci
npm run build
git add cv.pdf
git commit -m "github actions generated PDF on $(date +%Y-%m-%dT%H:%M:%S)"
git fetch origin master
git push origin HEAD:master