VLDLST_ARCH = i386

ifndef ARCH
$(error "The <ARCH> variable must be declared with one of the following values: $(VLDLST_ARCH)")
endif

ifeq ($(findstring $(ARCH), $(VLDLST_ARCH)),)
$(error "The <ARCH> variable must be declared with one of the following values: $(VLDLST_ARCH)")
endif

.PHONY: all clean

all:
	make -C arch/$(VLDLST_ARCH) -f build.mk
	make -C arch/$(VLDLST_ARCH) -f image.mk
	make -C arch/$(VLDLST_ARCH) -f emulate.mk

clean:
	make -C arch/i386/bootmbr -f build.mk clean