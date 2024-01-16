PTH_BUILD = build
PTH_BUILD_ENV = $(PTH_BUILD)/env
PTH_BUILD_ENV_MBR = $(PTH_BUILD_ENV)/mbr
PTH_BUILD_ENV_MBR_RAW = $(PTH_BUILD_ENV_MBR)/raw
PTH_BUILD_IMG = $(PTH_BUILD)/bin
PTH_BUILD_IMG_MBR = $(PTH_BUILD_IMG)/mbr
PTH_BUILD_IMG_MBR_RAW = $(PTH_BUILD_IMG_MBR)/raw

PTHLST_MKDIR = $(PTH_BUILD)
PTHLST_MKDIR += $(PTH_BUILD_ENV)
PTHLST_MKDIR += $(PTH_BUILD_ENV_MBR)
PTHLST_MKDIR += $(PTH_BUILD_ENV_MBR_RAW)

MBR_RAW_TOOL = qemu-system-i386
MBR_RAW_FLGS = -no-reboot -no-shutdown -net none
MBR_RAW_OPTH = $(PTH_BUILD_IMG_MBR_RAW)/image.img

.PHONY: all clean mkdir

all: clean mgr-raw

clean:
	@rm -rf $(PTH_BUILD_ENV)

mkdir:
	@for path in $(PTHLST_MKDIR) ; do \
	    mkdir -p "$${path}" ; \
	done

.PHONY: mgr-raw

mgr-raw: mkdir
	@$(MBR_RAW_TOOL) $(MBR_RAW_FLGS) -drive format=raw,file=$(MBR_RAW_OPTH)