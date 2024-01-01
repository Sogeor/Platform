#!/bin/bash

set -e

printf "[" > compile_commands.json

pushd include
find . -type f -name '*.asm' -exec bash -c '
printf "
    {
        \"directory\": \"%s\",
        \"arguments\": [
            \"nasm\",
            \"-f elf32\",
            \"-I ../build/include\",
            \"-Wall\",
            \"-O0\",
            \"-ffreestanding\",
            \"-c\",
            \"-o ../build/objects/$(dirname $1)/$(basename $1).o\",
            \"$1\"
        ],
        \"file\": \"$1\"
    }," "include" >> ../compile_commands.json
' shell {} \;
find . -type f -name '*.c' -exec bash -c '
printf "
    {
        \"directory\": \"%s\",
        \"arguments\": [
            \"i686-elf-gcc\",
            \"-I ../build/include\",
            \"-std=gnu17\",
            \"-Wall\",
            \"-O0\",
            \"-ffreestanding\",
            \"-c\",
            \"-o ../build/objects/$(dirname $1)/$(basename $1).o\",
            \"$1\"
        ],
        \"file\": \"$1\"
    }," "include" >> ../compile_commands.json
' shell {} \;
find . -type f -name '*.cpp' -exec bash -c '
printf "
    {
        \"directory\": \"%s\",
        \"arguments\": [
            \"i686-elf-gcc\",
            \"-I ../build/include\",
            \"-std=gnu++17\",
            \"-Wall\",
            \"-O0\",
            \"-ffreestanding\",
            \"-c\",
            \"-o ../build/objects/$(dirname $1)/$(basename $1).o\",
            \"$1\"
        ],
        \"file\": \"$1\"
    }," "include" >> ../compile_commands.json
' shell {} \;
popd

truncate -s -1 compile_commands.json

printf "
]" >> compile_commands.json