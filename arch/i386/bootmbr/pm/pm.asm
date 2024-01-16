extern __vbe_mode_brief
global __pm_enter
global __pm_leave
global __pm_clear_screen
global __pm_cursor

section .pm
bits 16

__pm_enter:
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
    jmp 0x8:.rt
.rt:
    ret

bits 32

__pm_leave:
    mov ax, 0x20
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    jmp 0x18:.bg

bits 16

.bg:
    mov eax, cr0
    and eax, ~1
    mov cr0, eax
    jmp 0x0:.rt
.rt:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    sti
    ret

bits 32

__pm_clear_screen:
    push eax
    push ecx
    push edi
    mov al, 0
    mov ecx, 0
;    mov cx, [__vbe_mode_brief + 4]
    mov cx, [__vbe_mode_brief + 6]
;    mov cx, [__vbe_controller_info + 18]
    mov edi, 0xB8000
    rep stosb
    pop edi
    pop ecx
    pop eax
    ret

__pm_cursor:
__pm_cursor_x: dw 0
__pm_cursor_y: dw 0