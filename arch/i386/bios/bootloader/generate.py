#!/usr/bin/python

from os.path import getsize, isfile
from sys import argv

code = f"""%define PLATFORM_BUILD_ARCH "i386"
%define NUMBER_OF_SECTORS {getsize(argv[1]) if isfile(argv[1]) else 0}
"""

with open(argv[2], "w") as file:
    file.write(code)
