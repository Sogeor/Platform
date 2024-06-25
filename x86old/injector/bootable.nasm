section .bootable
bits 16

jmp 0:start

halt: hlt
    jmp halt

die: mov ah, 0xE
    mov bx, 0
    mov cx, 14
    mov si, .msg
.loop: lodsb
    int 10h
    loop .loop
    jmp halt
.msg: db "Failed to boot"

start: xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax
    mov bp, 0x7DFF
    mov sp, bp
    mov ah, 0x42
    mov bx, BOOT_SIZE
    mov si, dap
.loop: cmp bx, 127
    jbe .finish
    int 13h
    jc die
    sub bx, 127
    add [dap_segment], word 127 * 512 / 16
    add [dap_low_lba], word 127
    jmp .loop
.finish: test bx, bx
    je .transfer
    mov [dap_sectors], bx
    int 13h
    jc die
.transfer: jmp 0x7E00

dap:
.size: db 16
.unused0: db 0
dap_sectors: dw 127
.offset: dw 0x7E00
dap_segment: dw 0
dap_low_lba: dd 1
.up_lba: dw 0
.unused1: dw 0

times 510 - ($ - $$) db 0
db 0x55, 0xAA

jmp die
