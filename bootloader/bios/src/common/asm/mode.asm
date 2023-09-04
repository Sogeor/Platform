extern writeln

global switch_to_real_mode
global switch_to_protected_mode
global prepare_unreal_mode
global switch_to_unreal_mode

bits 16
section .mode

switch_to_real_mode:
    push eax
    mov eax, cr0
    and al, 0xFE
    mov cr0, eax
    pop eax
    sti
    push si
    mov si, SWITCHING_TO_REAL_MODE
    call writeln
    pop si
    jmp 0x0:.free
.free:
    ret

switch_to_protected_mode:
    push si
    mov si, SWITCHING_TO_PROTECTED_MODE
    call writeln
    pop si
    cli
    push eax
    mov eax, cr0
    or al, 1
    mov cr0, eax
    pop eax
    ret
    jmp 0x8:.free
.free:
    ret

prepare_unreal_mode:
    push si
    mov si, PREPARING_UNREAL_MODE
    call writeln
    pop si
    push ds
    call switch_to_protected_mode
    call switch_to_unreal_mode
    pop ds
    ret

switch_to_unreal_mode:
    push eax
    push ds
    mov ax, 0x10
    mov ds, ax
    mov eax, cr0
    and al, 0xFE
    mov cr0, eax
    pop ds
    pop eax
    sti
    push si
    mov si, SWITCHING_TO_UNREAL_MODE
    call writeln
    pop si
    jmp 0x0:.free
.free:
    ret

SWITCHING_TO_REAL_MODE: db 'Switching to the read mode...', 0
SWITCHING_TO_PROTECTED_MODE: db 'Switching to the protected mode...', 0
PREPARING_UNREAL_MODE: db 'Preparing the unreal mode...', 0
SWITCHING_TO_UNREAL_MODE: db 'Switching to the unreal mode...', 0