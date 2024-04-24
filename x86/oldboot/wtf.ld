OUTPUT_FORMAT("binary")

STACK_SIZE = 4096;
stack_start = 0x400;
stack_end = stack_start + STACK_SIZE;
heap_start = stack_end + 1;
heap_end = 0x7BFF;

SECTIONS {
	. = 0x7C00;

	.text : {
	    header_start = .;
		*(.header)
	    header_end = .;

	    high_start = header_end + 1;
		code = high_start;
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

	. = 0x9FFFF;
	high_end = .;

	/DISCARD/ : {
		*(.comment)
		*(.eh_frame)
		*(.note.gnu.build-id)
	}
}