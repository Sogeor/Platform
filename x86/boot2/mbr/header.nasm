org 0x7C00
bits 16

jmp 0:l0
l0:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax
    ; 0x04FF <- overflow
    ; 0x0500 <- limit
    ; 0x24FF <- base
    mov bp, 0x24FF
    mov sp, bp
    mov si, dap
.lp:
    mov ah, 0x42
    int 13h
    jc die
    test ah, ah
    jnz die
    test bx, bx
    jz .dn
    cmp bx, 127
    jb .ex
    sub bp, [dap_number]
.ct:
    mov ax, 512 * 16
    mul word [dap_number]
    add [dap_segment], ax
    add dword [dap_lba_low], 1 ; TODO: full add (add to all lba parts)
.ex:
    mov [dap_number], bx
    jmp .ct
.dn:
    jmp 0x2500

die:
    mov ah, 0xE
    mov bx, 0
    mov cx, 14
    mov si, .m
.lp:
    lodsb
    int 10h
    loop .lp
.h:
    hlt
    jmp .h
.m: db "Failed to boot"

dap:
dap_size: db 16
dap_reserved: db 0
%if BOOT_SIZE > 127
dap_number: dw 127
%else
dap_number: dw BOOT_SIZE
%endif
dap_offset: dw 0x2500
dap_segment: dw 0
dap_lba_low: dd 1
dap_lba_up: dw 0
dap_lba_extra: dw 0

times 440 - ($ - $$) db 0
times 6 db 0

p1: times 16 db 0
p2: times 16 db 0
p3: times 16 db 0
p4: times 16 db 0

dw 0xAA55
