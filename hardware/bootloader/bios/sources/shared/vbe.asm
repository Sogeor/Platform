global __vbe_update_controller_info__
global __vbe_update_mode_info__
global __vbe_update_mode__
global __vbe_controller_info
global __vbe_mode_info
global __vbe_mode_summary

section .vbe
bits 16

__vbe_update_controller_info__:
    push di
    push es
    xor ax, ax
    mov es, ax
    mov ax, 0x4F00
    mov di, __vbe_controller_info
    int 0x10
    pop es
    pop di
    ret

__vbe_update_mode_info__:
    push di
    push es
    xor ax, ax
    mov es, ax
    mov ax, 0x4F01
    mov di, __vbe_mode_info
    int 0x10
    pop es
    pop di
    ret

__vbe_update_mode__:
    push di
    push es
    xor ax, ax
    mov es, ax
    mov ax, 0x4F02
    mov di, __vbe_mode_info
    int 0x10
    pop es
    pop di
    ret

__vbe_controller_info: times 512 db 0

__vbe_mode_info: times 256 db 0

__vbe_mode_summary: times 8 db 0