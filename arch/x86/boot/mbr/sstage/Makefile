OUTPUT_FILENAME := build.img
INTPUT_FILENAME := start.nasm

NASMC := nasm
NASMFLAGS := -f bin

.PHONY: all clean build
all: clean build
clean:
ifneq ($(wildcard $(OUTPUT_FILENAME)),)
	@echo "Deleting <$(OUTPUT_FILENAME)>"
	@rm -f $(OUTPUT_FILENAME)
endif
build:
	@echo "Compiling <$(INTPUT_FILENAME)> to <$(OUTPUT_FILENAME)>"
	@$(NASMC) $(NASMFLAGS) -o $(OUTPUT_FILENAME) $(INTPUT_FILENAME)
