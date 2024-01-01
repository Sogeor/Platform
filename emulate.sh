#!/bin/bash

set -e

if [ $# -ge 1 ]; then
  pushd arch
  ./emulate.sh "$1"
  popd
  exit 0
fi

pushd arch
./emulate.sh
popd
