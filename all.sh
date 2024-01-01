#!/bin/bash

set -e

if [ $# -ge 1 ]; then
  ./clean.sh "$1"
  ./build.sh "$1"
  ./image.sh "$1"
  ./emulate.sh "$1"
  exit 0
fi

./clean.sh
./build.sh
./image.sh
./emulate.sh
