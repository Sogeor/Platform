extern writeln
extern prepare_a20_line
extern gdt
extern prepare_drive_parameters
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
.continue:
    lgdt [gdt]
    mov eax, cr0
    or al, 1
    mov cr0, eax
    jmp pmode

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
    call prepare_drive_parameters
    mov ax, 0
    mov es, ax
    mov di, vbe_cont_info
    mov ax, 0x4F00
    int 0x10
    call bootloader_main
.loop:
    hlt
    jmp .loop