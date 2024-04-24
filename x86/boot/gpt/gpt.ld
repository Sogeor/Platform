OUTPUT_FORMAT("binary")

SECTIONS {
	. = 0x500;

	.text : {
		*(.gpt)
	}
}
