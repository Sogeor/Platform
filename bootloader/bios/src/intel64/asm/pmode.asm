extern vbe_mode_summary

global pmode_enter
global pmode_clear

section .pmode ; Определение секции для линковщика.
bits 16 ; Определение разрядности для компилятора и линковщика.

pmode_enter:
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

bits 32 ; Определение разрядности для компилятора и линковщика.

pmode_clear:
    push eax
    push ecx
    push edi
    mov al, 0
    mov ecx, 0
    mov cx, [vbe_mode_summary + 6]
    mov edi, 0xB8000
    rep stosb
    pop edi
    pop ecx
    pop eax
    ret