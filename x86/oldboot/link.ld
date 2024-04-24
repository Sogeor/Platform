OUTPUT_FORMAT("binary")

stack_start = 0x400;
stack_size = 4096;
stack_end = stack_size + stack_start;
heap_start = stack_end + 1;
heap_end = 0x7BFF;

SECTIONS {
	. = 0x7C00;

	.text : {
	    code = .;
	    header_start = .;
		*(.header)
	    header_end = .;

	    high_start = .;
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

	high_end = .;
	bootloader_end = .;

	/DISCARD/ : {
		*(.comment)
		*(.eh_frame)
		*(.note.gnu.build-id)
	}
}