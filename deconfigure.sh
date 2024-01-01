#!/bin/bash

set -e

if [ $# -ge 1 ]; then
  pushd arch
  ./deconfigure.sh "$1"
  popd
  exit 0
fi

pushd arch
./deconfigure.sh
popd
