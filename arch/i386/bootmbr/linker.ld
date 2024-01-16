OUTPUT_FORMAT("binary")

phys = 0x7C00;

SECTIONS {
	. = 0x7C00;

	.text : {
		code = .;
		*(.bootable)
		*(.main)
		*(.a20)
		*(.gdt)
/*		*(.io)*/
		*(.ptr)
		*(.pm)
		*(.jmp)
		*(.lifecycle)
		*(.rmode)
		*(.pmode)
		*(.vbe)
		*(.text)
/*		*(.main)*/
/*		*(.a20)*/
/*		*(.gdt)*/
/*/*		*(.io)*/*/
/*		*(.ptr)*/
/*		*(.pm)*/
/*		*(.jmp)*/
/*		*(.lifecycle)*/
/*		*(.rmode)*/
/*		*(.pmode)*/
/*		*(.vbe)*/
/*		*(.text)*/
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