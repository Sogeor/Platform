BOOT_METHOD =
_DV_BOOT_METHOD := mbr
_AV_BOOT_METHOD := $(_DV_BOOT_METHOD) # TODO: `gpt` is planned
ifndef BOOT_METHOD
$(warning BOOT_METHOD not defined. Used by default: $(_DV_BOOT_METHOD).)
override BOOT_METHOD := $(_DV_BOOT_METHOD)
endif
ifeq ($(findstring $(BOOT_METHOD), $(_AV_BOOT_METHOD)),)
$(error BOOT_METHOD is incorrectly set to $(BOOT_METHOD). Use: $(_AV_BOOT_METHOD))
endif

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

BOOT_IMAGE := boot.img

.PHONY: all clean build
all: clean build
clean:
	@echo "Deleting $(BOOT_IMAGE)..."
	@rm -f $(BOOT_IMAGE)
	@$(MAKE) -C mbr clean WARNINGS_LEVEL=$(WARNINGS_LEVEL)
build: build-$(BOOT_METHOD)

.PHONY: build-mbr
build-mbr:
	@$(MAKE) -C mbr build WARNINGS_LEVEL=$(WARNINGS_LEVEL)
