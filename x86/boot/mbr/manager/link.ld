OUTPUT_FORMAT("binary")

SECTIONS {
	. = 0x500;

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
	}

	/DISCARD/ : {
		*(.comment)
		*(.eh_frame)
		*(.note.gnu.build-id)
	}
}
