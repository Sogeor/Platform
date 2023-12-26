extern __boot_die
global __a20_prepare

section .a20
bits 16

__a20_prepare:
    call __a20_check
    cmp ax, 0
    je .rt
    call __a20_bios
    call __a20_check
    cmp ax, 0
    je .rt
    call __a20_ps2_controller
    call __a20_check
    cmp ax, 0
    je .rt
    call __a20_fast_gate
    call __a20_check
    cmp ax, 0
    je .rt
    call __a20_access
    call __a20_check
    cmp ax, 0
    je .rt
    jmp __boot_die
.rt:
    ret

__a20_check:
    cli
    push ds
    push es
    push di
    push si
    xor ax, ax
    mov es, ax
    not ax
    mov ds, ax
    mov di, 0x500
    mov si, 0x510
    mov dl, byte [es:di]
    push dx
    mov dl, byte [ds:si]
    push dx
    mov byte [es:di], 0
    mov byte [ds:si], 0xFF
    cmp byte [es:di], 0xFF
    je .rt
    mov ax, 0
.rt:
    pop dx
    mov byte [ds:si], dl
    pop dx
    mov byte [es:di], dl
    pop si
    pop di
    pop es
    pop ds
    sti
    ret

__a20_bios:
    mov ax, 0x2403
    int 0x15
    jb .rt
    cmp ah, 0
    jne .rt
    mov ax, 0x2402
    int 0x15
    jb .rt
    cmp ah, 0
    jne .rt
    cmp al, 1
    je .rt
    mov ax, 0x2401
    int 0x15
.rt:
    ret

__a20_ps2_controller:
    cli
    call .w1
    mov al, 0xAD
    out 0x64, al
    call .w1
    mov al, 0xD0
    out 0x64, al
    call .w2
    in al, 0x60
    push eax
    call .w1
    mov al, 0xD1
    out 0x64, al
    call .w1
    pop eax
    or al, 2
    out 0x60, al
    call .w1
    mov al, 0xAE
    out 0x64, al
    call .w1
    sti
    ret
.w1:
    in al, 0x64
    test al, 2
    jne .w1
    ret
.w2:
    in al, 0x64
    test al, 1
    je .w2
    ret

__a20_fast_gate:
    in al, 0x92
    test al, 2
    jne .rt
    or al, 2
    and al, 0xFE
    out 0x92, al
.rt:
    ret

__a20_access:
    in al, 0xEE
    ret