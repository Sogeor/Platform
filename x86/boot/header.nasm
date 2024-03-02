section .header

bits 16
header_start:

%ifndef BOOT_SIZE
%define BOOT_SIZE 0
jmp 0:header_die
%else
jmp 0:header_main
%endif ; BOOT_SIZE

header_stack_end:

times 512 - (header_end - header_stack_base) - (header_stack_end - header_start) db 0

header_stack_base:

global header_hlt
header_hlt:
    hlt
    jmp header_hlt

global header_die
header_die:
    mov ah, 0xE
    mov bx, 0xC
    mov cx, 27
    mov si, .msg
.loop:
    lodsb
    int 10h
    loop .loop
    jmp header_hlt
.msg: db "Failed to boot (0x00000001)" ; 27

extern boot_main
header_main:
    mov [disk], dl
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax
    mov bp, header_stack_base
    mov sp, bp
    mov ah, 0x42
    mov bx, BOOT_SIZE ; header_dap_sectors
    mov si, header_dap
.loop:
    cmp bx, 127
    jbe .final
    int 13h
    jc header_die
    sub bx, 127
    add [header_dap_segment], word 127 * 512 / 16
    add [header_dap_low_lba], word 127
    jmp .loop
.final:
    test bx, bx
    jz .jump
    mov [header_dap_sectors], bx
    int 13h
    jc header_die
.jump:
    jmp boot_main
    jmp header_die

global disk
disk: db 0

extern stack_end
header_dap:
header_dap_size: db 16
header_dap_unused_0: db 0
header_dap_sectors: dw BOOT_SIZE
header_dap_offset: dw stack_end
header_dap_segment: dw 0
header_dap_low_lba: dd 1 ; exclude header sector
header_dap_up_lba: dw 0
header_dap_unused_1: dw 0

dw 0xAA55

header_end:
