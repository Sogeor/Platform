MANAGER_SIZE =
ifndef MANAGER_SIZE
$(error MANAGER_SIZE not defined)
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

INJECTOR_IMAGE := injector.img

INJECTOR_SOURCE := start.nasm

NASMC := nasm

NASMFLAGS := -f bin
ifeq ($(WARNINGS_LEVEL), all)
NASMFLAGS += -w+all
endif
ifeq ($(WARNINGS_LEVEL), none)
NASMFLAGS += -w-all
endif

.PHONY: all clean build
all: clean build
clean:
ifneq ($(wildcard $(INJECTOR_IMAGE)),)
	@echo "Deleting $(INJECTOR_IMAGE)..."
	@rm -f $(INJECTOR_IMAGE)
endif
build:
	@echo "Compiling $(INJECTOR_SOURCE) in $(INJECTOR_IMAGE)..."
	@$(NASMC) $(NASMFLAGS) -o $(INJECTOR_IMAGE) $(INJECTOR_SOURCE) -d MANAGER_SIZE=$(MANAGER_SIZE)
