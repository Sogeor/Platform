#!/bin/bash

set -e

find . -maxdepth 1 -mindepth 1 -type d -not -name "build" -exec bash -c 'pushd "$1"
./configure.sh
popd' shell {} \;
