global __vbe_get_controller_info
global __vbe_get_mode_info
global __vbe_set_mode
global __vbe_controller_info
global __vbe_mode_info
global __vbe_mode_brief

section .vbe
bits 16

__vbe_get_controller_info:
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

__vbe_get_mode_info:
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

__vbe_set_mode:
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

__vbe_mode_brief:
__vbe_mode_brief_number: dw 0
__vbe_mode_brief_width: dw 0
__vbe_mode_brief_height: dw 0
__vbe_mode_brief_buffer_size: dw 0
;    vbe_mode_number_t number;
;    u16_t width;
;    u16_t height;
;    __attribute__((unused))
;    u16_t buffer_size;