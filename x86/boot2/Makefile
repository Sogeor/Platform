.PHONY: all clean build
all: clean build emulate-mbr
clean: clean-mbr clean-gpt
build: build-mbr build-gpt

.PHONY: clean-mbr build-mbr
clean-mbr:
	@$(MAKE) -C mbr clean
build-mbr:
	@$(MAKE) -C mbr build

.PHONY: clean-gpt build-gpt
clean-gpt:
	@$(MAKE) -C gpt clean
build-gpt:
	@$(MAKE) -C gpt build

.PHONY:
emulate-mbr: # TODO: REMOVE IT! ...
	@qemu-system-x86_64 -no-reboot -no-shutdown -net none -drive format=raw,file=mbr/boot.img
