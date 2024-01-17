global __rmode_print_symbol__

section .rmode
bits 16

__rmode_print_symbol__:
    push ax
    mov ah, 0xE
    lodsb
    int 0x10
    pop ax
    ret