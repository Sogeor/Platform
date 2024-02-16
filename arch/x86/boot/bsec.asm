extern msec_main

global bsec_halt
global bsec_die

bits 16
section .bsec

bsec_start:

%ifndef BOOT_SIZE
%define BOOT_SIZE 0
jmp 0:bsec_die
%else
jmp 0:bsec_main
%endif ; BOOT_SIZE

bsec_stack_limit:

times 512 - (bsec_end - bsec_stack_base) - (bsec_stack_limit - bsec_start) db 0

bsec_stack_base:

bsec_halt:
    hlt
    jmp bsec_halt

bsec_main:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax
    mov bp, bsec_stack_base
    mov sp, bp
    mov bx, BOOT_SIZE ; [bsec_dap + 2]
    mov ecx, 1 ; [bsec_dap + 8]
    mov ah, 0x42
    mov si, bsec_dap
.loop:
    cmp bx, 127
    jbe .final
    int 0x13
    jc bsec_die
    sub bx, 127
    add [bsec_dap + 6], word 127 * 512 / 16
    cmp ecx, 2 ^ 32 - 128
    ja bsec_die
    add ecx, 127
    mov [bsec_dap + 8], ecx
    jmp .loop
.final:
    mov [bsec_dap + 2], bx
    int 0x13
    jc bsec_die
    call msec_main

bsec_die:
    mov ah, 0xE
    mov bx, 0xC
    mov cx, [bsec_die_msg]
    mov si, bsec_die_msg + 2
.loop:
    lodsb
    int 0x10
    loop .loop
    jmp bsec_halt

bsec_die_msg:
    dw 14
    db "Failed to boot"

bsec_dap:
.size: db 16
.unused_0: db 0
.sec_num: dw BOOT_SIZE
.buf_off: dw msec_main
.buf_seg: dw 0
.low_lba: dd 1
.up_lba: dw 0
.unused_1: dw 0

dw 0xAA55

bsec_end:
