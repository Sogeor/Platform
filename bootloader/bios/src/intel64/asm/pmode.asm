extern halt
extern println

global enter_pmode

section .pmode ; Определение секции для линковщика.
bits 16 ; Определение разрядности для компилятора и линковщика.

enter_pmode:
    mov si, ENTER_PMODE
    call println
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x8:.flush
.flush:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov ss, ax
    ret

ENTER_PMODE: db 'Entering to protected mode...', 0