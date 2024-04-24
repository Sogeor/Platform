OUTPUT_FORMAT("binary")

STACK_BASE = 0x7DFF;

SECTIONS {
	. = 0x7E00;

	.text : {
	    code = .;
		*(.start)
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

	/DISCARD/ : {
		*(.comment)
		*(.eh_frame)
		*(.note.gnu.build-id)
	}
}
