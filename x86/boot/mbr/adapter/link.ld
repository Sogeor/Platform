OUTPUT_FORMAT("binary")

SECTIONS {
	. = 0x7E00;

	.text : {
		*(.start)
		*(.text)
	}

	.rodata BLOCK(1) : ALIGN(1) {
		*(.rodata)
	}

	.data BLOCK(1) : ALIGN(1) {
		*(.data)
	}

	.bss BLOCK(1) : ALIGN(1) {
		*(.bss)
		*(COMMON)
		*(.stack)
		stack = .;
	    . = ALIGN(512);
	}

	/DISCARD/ : {
		*(.comment)
		*(.eh_frame)
		*(.note.gnu.build-id)
	}
}
