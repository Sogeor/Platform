extern nmi_enable
extern nmi_disable

global pm_enter
global pm_leave

bits 16
section .pm

pm_enter:
;    call nmi_disable
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    jmp 0x8:.free
.free:
    ret

bits 32

pm_leave:
    mov ax, 0x20
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    jmp 0x18:.bridge

bits 16

.bridge:
    mov eax, cr0
    and eax, ~1
    mov cr0, eax
    jmp 0:.free
.free:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    sti
;    call nmi_enable
    ret
