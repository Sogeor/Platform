section .start
bits 32

extern stack
start:
    mov bp, stack
    mov ss, ax
    mov sp, bp

global halt
halt:
    cli
.loop:
    hlt
    jmp .loop
