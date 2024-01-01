#!/bin/bash

set -e

if [ $# -ge 1 ]; then
  pushd arch
  ./clean.sh "$1"
  popd
  exit 0
fi

pushd arch
./clean.sh
popd
