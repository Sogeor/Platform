extern halt
extern prepare_a20_line
extern prepare_gdt
extern prepare_unreal_mode
extern prepare_drive_parameters
extern vbe_cont_info
extern bootloader_main

global entrance

bits 16
section .entrance

entrance:
    call prepare_a20_line ; Подготовка линии A20.
    call prepare_gdt ; Подготовка таблицы глобальных дескрипторов.
    call prepare_unreal_mode ; Переход в нереальный режим.
    call prepare_drive_parameters
    mov ax, 0
    mov es, ax
    mov di, vbe_cont_info
    mov ax, 0x4F00
    int 0x10
    call bootloader_main
    jmp halt