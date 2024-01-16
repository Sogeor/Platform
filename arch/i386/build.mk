PTH_BUILD = build

PTHLST_MKDIR = $(PTH_BUILD)

# __bootmbr__

__bootmbr__PTH = bootmbr

__bootmbr__BMK = build.mk

# __bootmbr__

.PHONY: all clean mkdir

all: clean build

clean:
	@rm -rf $(PTH_BUILD)

mkdir:
	@for path in $(PTHLST_MKDIR) ; do \
	    mkdir -p "$${path}" ; \
	done

.PHONY: build

build: mkdir
	@make -C $(__bootmbr__PTH) -f $(__bootmbr__BMK)