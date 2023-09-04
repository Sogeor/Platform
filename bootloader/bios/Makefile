.PHONY: all clean setup amd64 intel64

PATH_SOURCE = src
PATH_SOURCE_AMD64 = ${PATH_SOURCE}/amd64
PATH_SOURCE_INTEL64 = ${PATH_SOURCE}/intel64

PATH_BUILD = build

all: intel64

clean:
	set -e
	rm -rf ${PATH_BUILD}

setup:
	set -e
	mkdir -p ${PATH_BUILD}

amd64: setup
	make -C ${PATH_SOURCE_AMD64}

intel64: setup
	make -C ${PATH_SOURCE_INTEL64}