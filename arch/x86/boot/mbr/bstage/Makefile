OUTPUT_FILENAME := build.img
INTPUT_FILENAME := start.nasm

NASMC := nasm
NASMFLAGS := -f bin

QEMU := qemu-system-i386
QEMUFLAGS := -net none -drive format=raw,file=$(OUTPUT_FILENAME)

.PHONY: all clean build debug
all: clean build debug
clean:
ifneq ($(wildcard $(OUTPUT_FILENAME)),)
	@echo "Deleting <$(OUTPUT_FILENAME)>"
	@rm -f $(OUTPUT_FILENAME)
endif
build:
	@echo "Compiling <$(INTPUT_FILENAME)> to <$(OUTPUT_FILENAME)>"
	@$(NASMC) $(NASMFLAGS) -o $(OUTPUT_FILENAME) $(INTPUT_FILENAME)
debug:
	@echo "Debugging <$(OUTPUT_FILENAME)> using <$(QEMU)>"
	@$(QEMU) $(QEMUFLAGS)
