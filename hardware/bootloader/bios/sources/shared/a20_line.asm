extern __halt__

global __a20_line_prepare__
global __a20_line_check__
global __a20_line_enable_using_bios__
global __a20_line_enable_using_ps2_controller__
global __a20_line_enable_using_fast_gate__

section .a20_line
bits 16

__a20_line_prepare__:
    call __a20_line_check__
    cmp ax, 0
    jz .free
    call __a20_line_enable_using_bios__
    call __a20_line_check__
    cmp ax, 0
    jz .free
    call __a20_line_enable_using_ps2_controller__
    call __a20_line_check__
    cmp ax, 0
    jz .free
    call __a20_line_enable_using_fast_gate__
    call __a20_line_check__
    cmp ax, 0
    jz .free
    jmp __halt__
.free:
    ret

__a20_line_check__:
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
    jz .disabled
.enabled:
    mov ax, 0
    jmp .free
.disabled:
    mov ax, 1
.free:
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

__a20_line_enable_using_bios__:
    mov ax, 0x2403
    int 0x15
    jb .not_supported
    cmp ah, 0
    jnz .not_supported
    mov ax, 0x2402
    int 0x15
    jb .could_not_get_status
    cmp ah, 0
    jnz .could_not_get_status
    cmp al, 1
    jz .already_enabled
    mov ax, 0x2401
    int 0x15
    jb .could_not_enable
    cmp ah, 0
    jnz .could_not_enable
.enabled:
    mov ax, 0
    ret
.not_supported:
    mov ax, 1
    ret
.could_not_get_status:
    mov ax, 2
    ret
.already_enabled:
    mov ax, 3
    ret
.could_not_enable:
    mov ax, 4
    ret

__a20_line_enable_using_ps2_controller__:
    cli
    call .wait_1
    mov al, 0xAD
    out 0x64, al
    call .wait_1
    mov al, 0xD0
    out 0x64, al
    call .wait_2
    in al, 0x60
    push eax
    call .wait_1
    mov al, 0xD1
    out 0x64, al
    call .wait_1
    pop eax
    or al, 2
    out 0x60, al
    call .wait_1
    mov al, 0xAE
    out 0x64, al
    call .wait_1
    sti
    ret
.wait_1:
    in al, 0x64
    test al, 2
    jnz .wait_1
    ret
.wait_2:
    in al, 0x64
    test al, 1
    jz .wait_2
    ret

__a20_line_enable_using_fast_gate__:
    in al, 0x92
    test al, 2
    jnz .free
    or al, 2
    and al, 0xFE
    out 0x92, al
.free:
    ret