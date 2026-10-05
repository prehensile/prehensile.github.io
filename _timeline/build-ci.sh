#!/bin/bash

set -e

export SOURCE_DIR="./content"
export DESTINATION_DIR="../timeline"

# use commit timestamps, since file mtimes are reset on checkout
md_timestamp=$(git log -1 --format=%ct -- ":(glob)$SOURCE_DIR/**/*.md")
html_timestamp=$(git log -1 --format=%ct -- $DESTINATION_DIR/index.html)

if [ "${md_timestamp:-0}" -gt "${html_timestamp:-0}" ]; then
    echo "Building timeline..."
    npm ci
    npm run build
    cp -R _site/* $DESTINATION_DIR
    git add $DESTINATION_DIR
    if git diff --cached --quiet; then
        echo "Build produced no changes, nothing to commit"
        exit 0
    fi
    git commit -m "github actions generated timeline on $(date +%Y-%m-%dT%H:%M:%S)"
    # the cv workflow may have pushed in the meantime
    git pull --rebase origin master
    git push origin HEAD:master
else
    echo "timeline is up to date with content, no action needed"
    exit 0
fi
