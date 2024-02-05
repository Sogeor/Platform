PTH_BUILD = build
PTH_BUILD_IMG = $(PTH_BUILD)/bin
PTH_BUILD_IMG_MBR = $(PTH_BUILD_IMG)/mbr
PTH_BUILD_IMG_MBR_RAW = $(PTH_BUILD_IMG_MBR)/raw

PTHLST_MKDIR = $(PTH_BUILD)
PTHLST_MKDIR += $(PTH_BUILD_IMG)
PTHLST_MKDIR += $(PTH_BUILD_IMG_MBR)
PTHLST_MKDIR += $(PTH_BUILD_IMG_MBR_RAW)

# __bootmbr__

#__bootmbr__PTH = bootmbr
#__bootmbr__PTH_BUILD = $(__bootmbr__PTH)/build
#__bootmbr__PTH_BUILD_BIN = $(__bootmbr__PTH_BUILD)/bin
__bootmbr__PTH = ../x86/boot
__bootmbr__PTH_BUILD = $(__bootmbr__PTH)/build

__bootmgr__OFLN = bootx86.bin

#__bootmgr__OPTH = $(__bootmbr__PTH_BUILD_BIN)/bootmbr.img
__bootmgr__OPTH = $(__bootmbr__PTH_BUILD)/$(__bootmgr__OFLN)

# __bootmbr__

MBR_RAW_OPTH = $(PTH_BUILD_IMG_MBR_RAW)/image.img

.PHONY: all clean mkdir

all: clean mgr-raw

clean:
	@rm -rf $(PTH_BUILD)

mkdir:
	@for path in $(PTHLST_MKDIR) ; do \
	    mkdir -p "$${path}" ; \
	done

.PHONY: mgr-raw

mgr-raw: mkdir
	#mkisofs -V "BOOTLOADER" -o $(MBR_RAW_OPTH) -b $(__bootmgr__OFLN) -no-emul-boot "$(__bootmbr__PTH_BUILD)"
	dd if=$(__bootmgr__OPTH) of=$(MBR_RAW_OPTH) conv=notrunc