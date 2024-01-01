#!/bin/bash

set -e

qemu-system-i386 -no-reboot -no-shutdown -drive format=raw,file=build/image.raw -net none