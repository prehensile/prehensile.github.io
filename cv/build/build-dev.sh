#!/bin/bash

set -e

export SOURCE_DIR="../src"
export DESTINATION_DIR=".."

if [ "$1" = "-w" ]; then
  npm run watch
else
npm run build
fi
