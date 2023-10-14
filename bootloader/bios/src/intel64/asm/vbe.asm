global vbe_update_controller_info
global vbe_update_mode_info
global vbe_update_mode
global vbe_controller_info
global vbe_mode_info
global vbe_mode_summary

section .vbe
bits 16

vbe_update_controller_info:
    push di
    push es
    xor ax, ax
    mov es, ax
    mov ax, 0x4F00
    mov di, vbe_controller_info
    int 0x10
    pop es
    pop di
    ret

vbe_update_mode_info:
    push di
    push es
    xor ax, ax
    mov es, ax
    mov ax, 0x4F01
    mov di, vbe_mode_info
    int 0x10
    pop es
    pop di
    ret

vbe_update_mode:
    push di
    push es
    xor ax, ax
    mov es, ax
    mov ax, 0x4F02
    mov di, vbe_mode_info
    int 0x10
    pop es
    pop di
    ret

vbe_controller_info: times 512 db 0

vbe_mode_info: times 256 db 0

vbe_mode_summary: times 6 db 0