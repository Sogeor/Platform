#!/bin/bash

set -e

rm -rf build

find . -maxdepth 1 -mindepth 1 -type d -not -name "build" -exec bash -c 'pushd "$1"
./clean.sh
popd' shell {} \;
