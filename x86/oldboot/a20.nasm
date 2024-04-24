section .a20

bits 16
extern boot_die
global a20_main
a20_main:
    call a20_check
    jne .free
    call a20_bios_enable
    call a20_check
    jne .free
    call a20_kbc_enable
    call a20_check
    jne .free
    call a20_gate_enable
    call a20_check
    jne .free
    call a20_port_enable
    call a20_check
    mov si, A20_MAIN_MSG_FAILED_TO_ENABLE_A20_LINE
    je boot_die
.free:
    ret

a20_check:
    push ds
    push es
    cli
    xor ax, ax ; 0
    mov es, ax
    not ax ; 0xFFFF
    mov ds, ax
    mov si, 0x500
    mov di, 0x510
    mov al, [ds:si]
    mov ah, [es:di]
    mov [ds:si], byte 0x00
    mov [es:di], byte 0xFF
    mov bl, [ds:si]
    mov bh, [es:di]
    cmp bl, bh
    mov [es:di], ah
    mov [ds:si], al
    sti
    pop es
    pop ds
    ret

a20_bios_enable:
    mov ax, 0x2401
    int 0x15
    ret

a20_kbc_enable:
    call a20_kbc_wait
    mov al, 0xD1
    out 0x64, al
    call a20_kbc_wait
    mov al, 0xDF
    out 0x60, al
    call a20_kbc_wait
    ret

a20_kbc_wait:
    ; todo: delay, but why?
    in al, 0x64
    test al, 2
    jnz a20_kbc_wait
    ret

a20_gate_enable:
    in al, 0x92
    test al, 2
    jnz .free
    or al, 2
    and al, ~1
    out 0x92, al
.free:
    ret

a20_port_enable:
    in al, 0xEE
    ret

A20_MAIN_MSG_FAILED_TO_ENABLE_A20_LINE:
    dw 38
    db "Failed to enable A20 line (0x00000002)"
