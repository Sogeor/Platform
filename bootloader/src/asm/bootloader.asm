bits 16

section .text

%include "build/include.asm"

extern bootloader_main

real_x16_bios_data:

times 90 db 0

real_x16_entry: jmp 0x00:.setup
.setup:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov sp, real_x16_entry

    mov [disk], dl
    cld

    mov si, real_x16_msg_sectors_reading
    call real_x16_prefixed_println
    call real_x16_read_sectors

    mov si, real_x16_msg_jumping_to_read_sectors
    call real_x16_prefixed_println
    jmp real_x16_entrance

real_x16_read_sectors:
.setup:
    xor dx, dx
    mov ax, 1
    mov cx, (bootloader_size - (real_x16_entrance - real_x16_bios_data)) / 512
    mov bx, real_x16_entrance
.start:
    cmp cx, 127
    jbe .reading
    pusha
    mov cx, 127
    call real_x16_read_sectors
    popa
    add eax, 127
    add dx, 127 * 512 / 16
    sub cx, 127
    jmp .start
.reading:
    mov [dap_lba_lower], ax
    mov [dap_sectors_number], cx
    mov [dap_buffer_segment], dx
    mov [dap_buffer_offset], bx
    mov dl, [disk]
    mov si, dap
    mov ah, 0x42
    int 0x13
    jc .error
    ret
.error:
    mov si, real_x16_msg_sectors_reading_error
    call real_x16_prefixed_println

real_x16_print:
    push ax
    push cx
    push si
    mov cx, word [si]
    add si, 2
.loop:
    lodsb
    mov ah, 0x0E
    int 0x10
    loop .loop, cx
    pop si
    pop cx
    pop ax
    ret

real_x16_prefixed_print:
    push si
    mov si, real_x16_msg_prefix
    call real_x16_print
    pop si
    call real_x16_print
    ret

real_x16_println:
    call real_x16_print
    push si
    mov si, bios_line_separator
    call real_x16_print
    pop si
    ret

real_x16_prefixed_println:
    call real_x16_prefixed_print
    push si
    mov si, bios_line_separator
    call real_x16_print
    pop si
    ret

disk db 0x80

global dap
dap: db 0x10
    db 0

global dap_sectors_number
dap_sectors_number: dw 0

global dap_buffer_offset
dap_buffer_offset: dw 0

global dap_buffer_segment
dap_buffer_segment: dw 0

global dap_lba_lower
dap_lba_lower: dd 0

global dap_lba_upper
dap_lba_upper: dd 0

bios_line_separator: dw 2
    db 13, 10

real_x16_msg_prefix: dw 11
    db '[real_x16] '

real_x16_msg_sectors_reading: dw 15
    db 'Reading sectors'

real_x16_msg_sectors_reading_error: dw 22
    db 'Unable to read sectors'

real_x16_msg_jumping_to_read_sectors: dw 23
    db 'Jumping to read sectors'

times 510 - ($ - $$) db 0
dw 0xAA55

real_x16_entrance:
    cli
    push ds
    push es
    mov si, msg_enabling_a20
    call real_x16_prefixed_println
    call enable_a20
    lgdt [gdtr]
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

msg_enabling_a20:
    dw 21
    db 'Enabling the A20 line'

enable_a20:
    call check_a20
    test ax, ax
    jnz .done
    call enable_a20_bios
    call check_a20
    test ax, ax
    jnz .done
    call enable_a20_keyboard_controller
    call check_a20
    test ax, ax
    jnz .done
    call enable_a20_io
    call check_a20
    test ax, ax
    jnz .done
.loop:
    hlt
    jmp .loop
.done:
    ret

check_a20:
    call check_a20_16
    test ax, ax
    jnz .a20_enabled
    mov si, a20_status_disabled
    call real_x16_prefixed_println
    ret
.a20_enabled:
    mov si, a20_status_enabled
    call real_x16_prefixed_println
    ret
a20_status_enabled:  dw 19
                     db 'A20 Status: ENABLED'
a20_status_disabled: dw 20
                     db 'A20 Status: DISABLED'

check_a20_16:
    pushf
    push ds
    push es
    push di
    push si
    cli
    xor ax, ax
    mov es, ax
    not ax
    mov ds, ax
    mov di, 0x0500
    mov si, 0x0510
    mov dl, byte [es:di]
    push dx
    mov dl, byte [ds:si]
    push dx
    mov byte [es:di], 0x00
    mov byte [ds:si], 0xFF
    cmp byte [es:di], 0xFF
    mov ax, 0
    je .a20_disabled
    mov ax, 1
.a20_disabled:
    pop dx
    mov byte [ds:si], dl
    pop dx
    mov byte [es:di], dl
    pop si
    pop di
    pop es
    pop ds
    popf
    sti
    ret

enable_a20_bios:
    mov ax, 0x2403
    int 0x15
    jb .failed
    cmp ah, 0
    jnz .failed
    mov ax, 0x2402
    int 0x15
    jb .failed
    cmp ah, 0
    jnz .failed
    cmp al, 1
    jz .done
    mov ax, 0x2401
    int 0x14
    jb .failed
    cmp ah, 0
    jnz .failed
.done:
    mov ax, 1
    ret
.failed:
    mov ax, 0
    ret

disable_a20_bios:
    mov ax, 0x2400
    int 0x15
    ret

enable_a20_keyboard_controller:
    cli
    call a20_wait1
    mov al, 0xAD
    out 0x64, al
    call a20_wait1
    mov al, 0xD0
    out 0x64, al
    call a20_wait2
    in al, 0x60
    push eax
    call a20_wait1
    mov al, 0xD1
    out 0x64, al
    call a20_wait1
    pop eax
    or al, 2
    out 0x60, al
    call a20_wait1
    mov al, 0xAE
    out 0x64, al
    call a20_wait1
    sti
    ret

a20_wait1:
    in al, 0x64
    test al, 2
    jnz a20_wait1
    ret

a20_wait2:
    in al, 0x64
    test al, 1
    jz a20_wait2
    ret

enable_a20_io:
    in al, 0x92
    test al, 2
    jnz .done
    or al, 2
    and al, 0xFE
    out 0x92, al
.done:
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