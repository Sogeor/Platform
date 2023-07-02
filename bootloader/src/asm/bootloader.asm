bits 16

section .text

%include "build/include.asm"

extern bootloader_main

global x16_real_dap_size
global x16_real_dap_reserved
global x16_real_dap_number_of_sectors
global x16_real_dap_buffer_offset
global x16_real_dap_buffer_segment
global x16_real_dap_lba_lower
global x16_real_dap_lba_upper

x16_real_bios_data: times 90 db 0
x16_real_entry: jmp 0x00:.setup
.setup:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov sp, x16_real_entry
    mov [disk], dl
    cld
.read_entrance_sectors:
    mov ax, (bootloader_size - 512) / 512
    mov bx, x16_real_entrance
    xor cx, cx
    mov edx, 1
    mov si, x16_real_msg_entrance_sectors_reading
    call x16_real_prefixed_println
    call x16_real_read_sectors
    jc .read_entrance_sectors_error
.jump_to_entrance_sectors:
    mov si, x16_real_msg_jumping_to_entrance_sectors
    call x16_real_prefixed_println
    jmp x16_real_entrance
.read_entrance_sectors_error:
    mov si, x16_real_msg_entrance_sectors_reading_error
    call x16_real_prefixed_println
.loop:
    hlt
    jmp .loop

x16_real_read_sectors:
.setup:
    cmp ax, 127
    jbe .reading
    push ax
    mov ax, 127
    call x16_real_read_sectors
    jc .error
    pop ax
    sub ax, 127
    add cx, 127 * 512 / 16
    add edx, 127
    jmp .setup
.error:
    ret
.reading:
    mov [x16_real_dap_number_of_sectors], ax
    mov [x16_real_dap_buffer_offset], bx
    mov [x16_real_dap_buffer_segment], cx
    mov [x16_real_dap_lba_lower], edx
    mov dl, [disk]
    mov si, x16_real_dap
    mov ah, 0x42
    int 0x13
    ret

x16_real_print:
    push ax
    push si
    mov ah, 0xE
.loop:
    lodsb
    cmp al, 0
    je .free
    int 0x10
    jmp .loop
.free:
    pop si
    pop ax
    ret

x16_real_prefixed_print:
    push si
    mov si, x16_real_msg_prefix
    call x16_real_print
    pop si
    call x16_real_print
    ret

x16_real_println:
    call x16_real_print
    push si
    mov si, x16_real_bios_line_separator
    call x16_real_print
    pop si
    ret

x16_real_prefixed_println:
    call x16_real_prefixed_print
    push si
    mov si, x16_real_bios_line_separator
    call x16_real_print
    pop si
    ret

disk db 0x80

x16_real_dap:
x16_real_dap_size: db 16
x16_real_dap_reserved: db 0
x16_real_dap_number_of_sectors: dw 0
x16_real_dap_buffer_offset: dw 0
x16_real_dap_buffer_segment: dw 0
x16_real_dap_lba_lower: dd 0
x16_real_dap_lba_upper: dd 0

x16_real_bios_line_separator: db 13, 10, 0
x16_real_msg_prefix: db '[real_x16] ', 0
x16_real_msg_entrance_sectors_reading: db 'Reading entrance sectors', 0
x16_real_msg_entrance_sectors_reading_error: db 'Unable to read entrance sectors', 0
x16_real_msg_jumping_to_entrance_sectors: db 'Jumping to entrance sectors', 0

times 510 - ($ - $$) db 0
dw 0xAA55

x16_real_entrance:
    cli
    push ds
    push es
    mov si, x16_real_msg_trying_to_enable_the_a20_line
    call x16_real_prefixed_println
    call x16_real_try_to_enable_the_a20_line
    cmp ax, 0
    jne .the_a20_line_is_not_enabled
.continue:
    lgdt [gdtr]
    mov eax, cr0
    or al, 1
    mov cr0, eax
    jmp pmode
.the_a20_line_is_not_enabled:
    push si
    mov si, x16_real_msg_correct_behavior_with_the_disabled_a20_line_is_not_guaranteed
    call x16_real_prefixed_println
    jmp .continue

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

x16_real_msg_trying_to_enable_the_a20_line: db 'Trying to enable the A20 line', 0
x16_real_msg_the_a20_line_already_enabled: db 'The A20 line already enabled', 0
x16_real_msg_the_a20_line_is_enabled_using_the_bios: db 'The A20 line is enabled using the BIOS', 0
x16_real_msg_the_a20_line_enabling_is_not_supported_using_the_bios: db 'The A20 line enabling is not supported using the BIOS', 0
x16_real_msg_could_not_get_the_a20_line_status_using_the_bios: db 'Could not get the A20 line status using the BIOS', 0
x16_real_msg_the_a20_line_could_not_be_enabled_using_the_bios: db 'The A20 line could not be enabled using the BIOS', 0
x16_real_msg_the_a20_line_is_enabled_using_the_keyboard_controller: db 'The A20 line is enabled using the keyboard controller', 0
x16_real_msg_the_a20_line_is_enabled_using_the_fast_gate: db 'The A20 line is enabled using the fast gate', 0
x16_real_msg_the_a20_line_could_not_be_enabled_using_the_fast_gate: db 'The A20 line could not be enabled using the fast gate', 0
x16_real_msg_failed_to_enable_the_a20_line: db 'Failed to enable the A20 line', 0
x16_real_msg_correct_behavior_with_the_disabled_a20_line_is_not_guaranteed: db 'Correct behavior with the disabled A20 line is not guaranteed', 0

x16_real_try_to_enable_the_a20_line:
    call x16_real_check_the_a20_line
    jne .already_enabled
.try_enable_using_the_bios:
    call x16_real_try_enable_the_a20_line_using_the_bios
    cmp ax, 0
    je .enabled_using_the_bios
    cmp ax, 1
    je .not_supported_using_the_bios
    cmp ax, 2
    je .could_not_get_status_using_the_bios
    cmp ax, 3
    je .already_enabled_using_the_bios
.could_not_enable_using_the_bios:
    push si
    mov si, x16_real_msg_the_a20_line_could_not_be_enabled_using_the_bios
    call x16_real_prefixed_println
    pop si
.try_enable_using_the_keyboard_controller:
    call x16_real_try_enable_the_a20_line_using_the_keyboard_controller
    call x16_real_check_the_a20_line
    jne .enabled_using_the_keyboard_controller
.try_enable_using_the_fast_gate:
    call x16_real_try_enable_the_a20_line_using_the_fast_gate
    call x16_real_check_the_a20_line
    jne .enabled_using_the_fast_gate
.not_enabled_using_the_fast_gate:
    push si
    mov si, x16_real_msg_the_a20_line_could_not_be_enabled_using_the_fast_gate
    call x16_real_prefixed_println
    pop si
.not_enabled:
    push si
    mov si, x16_real_msg_failed_to_enable_the_a20_line
    call x16_real_prefixed_println
    pop si
    mov ax, 1
    ret
.already_enabled:
    push si
    mov si, x16_real_msg_the_a20_line_already_enabled
    call x16_real_prefixed_println
    pop si
    jmp .enabled
.enabled_using_the_bios:
    call x16_real_check_the_a20_line
    je .try_enable_using_the_keyboard_controller
    push si
    mov si, x16_real_msg_the_a20_line_already_enabled
    call x16_real_prefixed_println
    pop si
    jmp .enabled
.not_supported_using_the_bios:
    push si
    mov si, x16_real_msg_the_a20_line_enabling_is_not_supported_using_the_bios
    call x16_real_prefixed_println
    pop si
    jmp .try_enable_using_the_keyboard_controller
.could_not_get_status_using_the_bios:
    push si
    mov si, x16_real_msg_could_not_get_the_a20_line_status_using_the_bios
    call x16_real_prefixed_println
    pop si
    jmp .try_enable_using_the_keyboard_controller
.already_enabled_using_the_bios:
    call x16_real_check_the_a20_line
    je .try_enable_using_the_keyboard_controller
    jmp .already_enabled
.enabled_using_the_keyboard_controller:
    push si
    mov si, x16_real_msg_the_a20_line_is_enabled_using_the_keyboard_controller
    call x16_real_prefixed_println
    pop si
    jmp .enabled
.enabled_using_the_fast_gate:
    call x16_real_check_the_a20_line
    je .not_enabled_using_the_fast_gate
    push si
    mov si, x16_real_msg_the_a20_line_is_enabled_using_the_fast_gate
    call x16_real_prefixed_println
    pop si
.enabled:
    mov ax, 0
    ret

x16_real_check_the_a20_line:
.setup:
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
.compare:
    cmp byte [es:di], 0xFF
    je .disabled
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

x16_real_try_enable_the_a20_line_using_the_bios:
.check_support:
    mov ax, 0x2403
    int 0x15
    jb .not_supported
    cmp ah, 0
    jnz .not_supported
.try_get_status:
    mov ax, 0x2402
    int 0x15
    jb .could_not_get_status
    cmp ah, 0
    jnz .could_not_get_status
    cmp al, 1
    jz .already_enabled
.try_enable:
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

x16_real_disable_the_a20_line_using_the_bios:
    push ax
    mov ax, 0x2400
    int 0x15
    pop ax
    ret

x16_real_try_enable_the_a20_line_using_the_keyboard_controller:
    cli
    call .wait
    mov al, 0xAD
    out 0x64, al
    call .wait
    mov al, 0xD0
    out 0x64, al
    call .co_wait
    in al, 0x60
    push eax
    call .wait
    mov al, 0xD1
    out 0x64, al
    call .wait
    pop eax
    or al, 2
    out 0x60, al
    call .wait
    mov al, 0xAE
    out 0x64, al
    call .wait
    sti
    ret
.wait:
    in al, 0x64
    test al, 2
    jnz .wait
    ret
.co_wait:
    in al, 0x64
    test al, 1
    jz .co_wait
    ret

x16_real_try_enable_the_a20_line_using_the_fast_gate:
    in al, 0x92
    test al, 2
    jnz .free
    or al, 2
    and al, 0xFE
    out 0x92, al
    jmp .free
.free:
    ret

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
    mov si, x16_real_dap ;dap
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