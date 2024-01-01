#!/bin/bash

set -e

./clean.sh
./build.sh
./image.sh
./emulate.sh
