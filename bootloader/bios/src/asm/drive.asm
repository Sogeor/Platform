extern disk

global ask_drive_params
global drive_params
global drive_params_bps
global gdt_end

bits 16
section .text

ask_drive_params:
    mov ah, 0x48
    mov dl, [disk]
    mov si, drive_params
    int 0x13
    ret

drive_params:
    dw 0x1A
    dw 0
    dd 0
    dd 0
    dd 0
    dd 0
    dd 0

drive_params_bps: dw 0
