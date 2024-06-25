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

MBR_IMAGE := mbr.img

INJECTOR_IMAGE := injector/injector.img

MANAGER_IMAGE := manager/manager.img

.PHONY: all clean build
all: clean build
clean:
ifneq ($(wildcard $(MBR_IMAGE)),)
	@echo "Deleting $(MBR_IMAGE)..."
	@rm -f $(MBR_IMAGE)
endif
	@$(MAKE) -C injector clean MANAGER_SIZE=0
	@$(MAKE) -C manager clean
build: build-image

.PHONY: build-injector build-manager build-image
build-injector: build-manager
	@echo "Setting MANAGER_SIZE to $(shell expr $(shell expr $(shell wc -c < $(MANAGER_IMAGE)) + 511) / 512)..."
	@$(MAKE) -C injector build MANAGER_SIZE=$(shell expr $(shell expr $(shell wc -c < $(MANAGER_IMAGE)) + 511) / 512)
build-manager:
	@$(MAKE) -C manager build
build-image: build-injector
	@echo "Compiling $(MBR_IMAGE)..."
	@cat $(INJECTOR_IMAGE) $(MANAGER_IMAGE) > $(MBR_IMAGE)
