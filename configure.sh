#!/bin/bash

set -e

if [ $# -ge 1 ]; then
  pushd arch
  ./configure.sh "$1"
  popd
  exit 0
fi

pushd arch
./configure.sh
popd
