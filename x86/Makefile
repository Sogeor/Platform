X86_IMAGE_FORMAT =
_DV_X86_IMAGE_FORMAT := iso9660
_AV_X86_IMAGE_FORMAT := $(_DV_X86_IMAGE_FORMAT) # TODO: `udf` is planned
ifndef X86_IMAGE_FORMAT
$(warning X86_IMAGE_FORMAT not defined. Used by default: $(_DV_X86_IMAGE_FORMAT).)
override X86_IMAGE_FORMAT := $(_DV_X86_IMAGE_FORMAT)
endif
ifeq ($(findstring $(X86_IMAGE_FORMAT), $(_AV_X86_IMAGE_FORMAT)),)
$(error X86_IMAGE_FORMAT incorrectly defined. Use: $(_AV_X86_IMAGE_FORMAT))
endif

X86_PARTITION_TABLE =
_DV_X86_PARTITION_TABLE := mbr
_AV_X86_PARTITION_TABLE := $(_DV_X86_PARTITION_TABLE) # TODO: `gpt` is planned
ifndef X86_PARTITION_TABLE
$(warning X86_PARTITION_TABLE not defined. Used by default: $(_DV_X86_PARTITION_TABLE).)
override X86_PARTITION_TABLE := $(_DV_X86_PARTITION_TABLE)
endif
ifeq ($(findstring $(X86_PARTITION_TABLE), $(_AV_X86_PARTITION_TABLE)),)
$(error X86_PARTITION_TABLE is incorrectly set to $(X86_PARTITION_TABLE). Use: $(_AV_X86_PARTITION_TABLE))
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

X86_IMAGE := x86.img

X86_BOOT_IMAGE =

.PHONY: all clean build
all: clean build
clean:
ifneq ($(wildcard $(X86_IMAGE)),)
	@echo "Deleting $(X86_IMAGE)..."
	@rm -f $(X86_IMAGE)
endif
	@$(MAKE) -C boot clean BOOT_METHOD=$(X86_PARTITION_TABLE) WARNINGS_LEVEL=$(WARNINGS_LEVEL)
build: build-boot

.PHONY: build-boot
build-boot:
	@$(MAKE) -C boot build BOOT_METHOD=$(X86_PARTITION_TABLE) WARNINGS_LEVEL=$(WARNINGS_LEVEL)
