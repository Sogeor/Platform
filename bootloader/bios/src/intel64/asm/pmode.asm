global enter_pmode

section .pmode ; Определение секции для линковщика.
bits 16 ; Определение разрядности для компилятора и линковщика.

enter_pmode:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    jmp 0x8:.flush
.flush:
    ret