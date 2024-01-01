#!/bin/bash

set -e

if [ $# -ge 1 ]; then
  pushd "$1"
  ./build.sh
  popd
  exit 0
fi

find . -maxdepth 1 -mindepth 1 -type d -exec bash -c './build.sh "$1"' shell {} \;
