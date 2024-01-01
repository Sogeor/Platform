#!/bin/bash

set -e

if [ $# -ge 1 ]; then
  pushd "$1"
  ./deconfigure.sh
  popd
  exit 0
fi

find . -maxdepth 1 -mindepth 1 -type d -exec bash -c './deconfigure.sh "$1"' shell {} \;
