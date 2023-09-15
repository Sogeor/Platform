global get_vbe_controller_info
global vbe_controller_info

section .gdt ; Определение секции для линковщика.
bits 16 ; Определение разрядности для компилятора и линковщика.

get_vbe_controller_info:
    push ax
    push di
    xor ax, ax
    mov es, ax
    mov ax, 0x4F00
    mov di, vbe_controller_info
    int 0x10
    pop di
    pop ax
    ret

vbe_controller_info: times 512 db 0