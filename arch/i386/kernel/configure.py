#!/usr/bin/python

from os import getcwd, walk

root = getcwd().replace("\\", "/") + "/include"

code = "["

for path, _, files in walk(root):
    path = path.replace("\\", "/")
    for file in files:
        if file.endswith(".asm"):
            code += f"""
    {{
        "directory": "{root}",
        "arguments": [
            "nasm",
            "-I ../build/include",
            "-f elf32",
            "-o ../build/objects/{path}/{file[:-4]}.o",
            "{path}/{file}"
        ],
        "file": "{path}/{file}"
    }},"""
        if file.endswith(".c"):
            code += f"""
    {{
        "directory": "{root}",
        "arguments": [
            "i686-elf-gcc",
            "-I ../build/include",
            "-std=gnu17",
            "-Wall",
            "-O0",
            "-ffreestanding",
            "-c",
            "-o ../build/objects/{path}/{file[:-4]}.o",
            "{path}/{file}"
        ],
        "file": "{path}/{file}"
    }},"""
        if file.endswith(".cpp"):
            code += f"""
    {{
        "directory": "{root}",
        "arguments": [
            "i686-elf-g++",
            "-I ../build/include",
            "-std=gnu++17",
            "-Wall",
            "-O0",
            "-ffreestanding",
            "-c",
            "-o ../build/objects/{path}/{file[:-4]}.o",
            "{path}/{file}"
        ],
        "file": "{path}/{file}"
    }},"""

code = code[:-1]

code += """
]"""

with open("compile_commands.json", "w") as file:
    file.write(code)
