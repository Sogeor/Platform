#!/bin/bash

set -e

if [ $# -ge 1 ]; then
  pushd arch
  ./image.sh "$1"
  popd
  exit 0
fi

pushd arch
./image.sh
popd
