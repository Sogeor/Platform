bits 16

section .text

%include "build/include.asm"

times 90 db 0

jmp 0:entry

%include "src/asm/early.asm"

%include "src/asm/print.asm"

%include "src/asm/dap.asm"

times 510 - ($ - $$) db 0

dw 0xAA55

extern bootloader_main

entrance:
    cli
    push ds
    push es
    call prepare_a20_line
    cmp ax, 0
    jnz .a20_line_is_not_enabled
.continue:
    lgdt [gdtr]
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

%include "src/asm/a20_line.asm"

global ask_drive_params
ask_drive_params:
    mov ah, 0x48
    mov dl, [disk]
    mov si, drive_params
    int 0x13
    ret

global enter_protected_mode
enter_protected_mode:
    cli
    xor ax, ax
    mov ds, ax
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    jmp 0x08:complete_flush
complete_flush:
    ret

pm_stack: dd 0
          dd 0

global do_bios_call
do_bios_call:
bits 32
    push ebp
    mov ebp, esp
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    mov eax, esp
    mov [pm_stack], eax
    mov ax, 0x20
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    jmp 0x18:.0
.0:
bits 16
    mov eax, cr0
    and eax, ~1
    mov cr0, eax
    jmp 0x00:.1
.1:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    sti
    mov ebx, [esp + 32]
    mov ax, 0x01
    cmp ax, bx
    je .read_disk
    mov ax, 0x02
    cmp ax, bx
    je .query_mode
    mov ax, 0x03
    cmp ax, bx
    je .set_mode
    jmp .done
.read_disk:
    mov ah, 0x42
    mov dl, [disk]
    mov si, dap
    int 0x13
    jmp .done
.query_mode:
    mov ecx, [esp + 36]
    mov ax, 0
    mov es, ax
    mov edi, vbe_info
    mov ax, 0x4F01
    int 0x10
    jmp .done
.set_mode:
    mov ebx, [esp + 36]
    mov ax, 0x4F02
    int 0x10
    jmp .done
.done:
    cli
    xor ax, ax
    mov ds, ax
    lgdt [gdtr]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x08:.2
.2:
bits 32
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov eax, [pm_stack]
    mov esp, eax
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    pop ebp
    ret

align 8,  db 0
gdtr:     dw gdt_end - gdt_base - 1
          dd gdt_base
gdt_base: dd 0 ; null descriptor
          dd 0

          dw 0xFFFF
          dw 0
          db 0
          db 0x9A
          db 0xCF
          db 0

          dw 0xFFFF
          dw 0
          db 0
          db 0x92
          db 0xCF
          db 0
          dw 0xFFFF

          dw 0
          db 0
          db 0x9E
          db 0
          db 0
          dw 0xFFFF
          dw 0
          db 0
          db 0x92
          db 0
          db 0
gdt_end:

;x32_protected_gdtr: dw 0
;    dd 0
;
;x32_protected_gdt:
;x32_protected_gdt_null_descriptor: dd 0
;    dd 0
;x32_protected_gdt_null_descriptor: dd 0
;    dd 0

align 4, db 0
global drive_params
drive_params: dw 0x1A
              dw 0
              dd 0
              dd 0
              dd 0
              dd 0
              dd 0
global drive_params_bps
drive_params_bps: dw 0

align 4, db 0
global vbe_info
vbe_info: dw 0
          dw 0
          dw 0
          dw 0
          dd 0
          dd 0
global vbe_info_pitch
vbe_info_pitch:
          dw 0
global vbe_info_width
vbe_info_width:
          dw 0
global vbe_info_height
vbe_info_height:
          dw 0
          dw 0
          db 0
global vbe_info_bpp
vbe_info_bpp:
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
global vbe_info_fbaddr
vbe_info_fbaddr:
          dd 0
          dd 0
          dw 0
          times 206 db 0

vbe_cont_info:
          db "VBE2"
          dw 0x200
          dd 0
          dd 0
global vbe_cont_info_mode_off
vbe_cont_info_mode_off:
          dw 0
vbe_cont_info_mode_seg:
          dw 0
          times 494 db 0

global disk_space
disk_space: times 2048 db 0

align 512, db 0

second_stage_end: