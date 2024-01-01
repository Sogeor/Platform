#!/bin/bash

set -e

mkdir -p build

find . -maxdepth 1 -mindepth 1 -type d -not -name "build" -exec bash -c 'pushd "$1"
./build.sh
popd' shell {} \;
