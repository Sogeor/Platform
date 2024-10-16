OUTPUT_FORMAT("binary")
ENTRY(start)
SECTIONS {
    . = 0x7E00;
    .text : {
		*(.text)
    }
	.rodata : {
		*(.rodata)
	}
	.data : {
		*(.data)
	}
	.bss : {
		*(COMMON)
		*(.bss)
		*(.stack)
	}
	/DISCARD/ : {
		*(.comment)
		*(.eh_frame)
		*(.note.gnu.build-id)
	}
}
