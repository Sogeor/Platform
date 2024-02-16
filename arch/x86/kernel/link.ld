ENTRY(_start)
OUTPUT_FORMAT(elf64-x86-64)

SECTIONS {
    . = 0;

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
		*(.bss)
    }
}