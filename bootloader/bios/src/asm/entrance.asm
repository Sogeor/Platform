extern println
extern prepare_a20_line
extern gdt
extern ask_drive_params
extern vbe_cont_info
extern bootloader_main

global entrance

bits 16
section .text

entrance:
    cli
    push ds
    push es
    call prepare_a20_line
    cmp ax, 0
    jnz .a20_line_is_not_enabled
.continue:
    lgdt [gdt]
    mov eax, cr0
    or al, 1
    mov cr0, eax
    jmp pmode
.a20_line_is_not_enabled:
    mov si, x16_real_msg_correct_behavior_with_the_disabled_a20_line_is_not_guaranteed
    call println
    jmp .continue

x16_real_msg_correct_behavior_with_the_disabled_a20_line_is_not_guaranteed: db 'Correct behavior with the disabled A20 line is not guaranteed', 0

pmode:
    mov bx, 0x10
    mov ds, bx
    mov es, bx
    and al, 0xFE
    mov cr0, eax
    jmp unreal

unreal:
    pop es
    pop ds
    call ask_drive_params
    mov ax, 0
    mov es, ax
    mov di, vbe_cont_info
    mov ax, 0x4F00
    int 0x10
    call bootloader_main
.loop:
    hlt
    jmp .loop