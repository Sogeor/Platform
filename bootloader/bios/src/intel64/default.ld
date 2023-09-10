OUTPUT_FORMAT("binary")

phys = 0x7c00;

SECTIONS {
	. = 0x7c00;

	.text : {
		code = .;
		*(.injector)
		*(.launcher)
		*(.a20_line)
		*(.gdt)
		*(.pmode)
		*(.text)
	}

	.rodata BLOCK(1) : ALIGN(1) {
		*(.rodata)
	}

	.data BLOCK(1) : ALIGN(1) {
		data = .;
		*(.data)
	}

	.bss BLOCK(1) : ALIGN(1) {
		PROVIDE(_bss_start = .);
		bss = .;
		*(COMMON)
		*(.bss)
		*(.stack)
		PROVIDE(_bss_end = .);
	}

	bootloader_end = .;

	/DISCARD/ : {
		*(.comment)
		*(.eh_frame)
		*(.note.gnu.build-id)
	}
}