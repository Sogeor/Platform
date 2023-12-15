extern __gdtr

global __pmode_enter__
global __pmode_leave__
global __pmode_cursor
global __pmode_cursor_x
global __pmode_cursor_y

section .pmode
bits 16

__pmode_enter__:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    jmp 0x8:.flush
.flush:
    ret

bits 32

__pmode_leave__:
    mov ax, 0x20
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    jmp 0x18:.bridge

bits 16

.bridge:
    mov eax, cr0
    and eax, ~1
    mov cr0, eax
    jmp 0x0:.flush
.flush:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    sti
    ret

bits 32

bits 32

__pmode_clear_screen__:
    push eax
    push ecx
    push edi
    mov al, 0
    mov ecx, 0
;    mov cx, [vbe_mode_summary + 6]
    mov edi, 0xB8000
    rep stosb
    pop edi
    pop ecx
    pop eax
    ret

align 1

__pmode_cursor:
__pmode_cursor_x: dw 0
__pmode_cursor_y: dw 0