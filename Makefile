WARNINGS_LEVEL =
_DV_WARNINGS_LEVEL := all
_AV_WARNINGS_LEVEL := $(_DV_WARNINGS_LEVEL);none
ifndef WARNINGS_LEVEL
$(warning WARNINGS_LEVEL not defined. Used by default: $(_DV_WARNINGS_LEVEL).)
override WARNINGS_LEVEL := $(_DV_WARNINGS_LEVEL)
endif
ifeq ($(findstring $(WARNINGS_LEVEL), $(_AV_WARNINGS_LEVEL)),)
$(error WARNINGS_LEVEL is incorrectly set to $(WARNINGS_LEVEL). Use: $(_AV_WARNINGS_LEVEL))
endif

.PHONY: all clean build
all: clean build
clean:
	@$(MAKE) -C x86 clean WARNINGS_LEVEL=$(WARNINGS_LEVEL)
build: build-x86

.PHONY: build-x86
build-x86:
	@$(MAKE) -C x86 build WARNINGS_LEVEL=$(WARNINGS_LEVEL)
