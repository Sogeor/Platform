NASM := nasm
NASMFLAGS := -f bin

RMSTAGE_OUT := rmstage.img

.PHONY: all clean build
all: clean build
clean:
	@rm -f $(RMSTAGE_OUT)
build:
	@$(NASM) $(NASMFLAGS) -o $(RMSTAGE_OUT) start.nasm
