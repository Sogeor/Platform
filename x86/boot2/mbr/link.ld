OUTPUT_FORMAT("binary")

SECTIONS {
	. = 0x2300;

	.text : {
	    code = .;
		*(.enjoy)
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
