#!/bin/bash

set -e

if [ $# -ge 1 ]; then
  pushd arch
  ./build.sh "$1"
  popd
  exit 0
fi

pushd arch
./build.sh
popd
