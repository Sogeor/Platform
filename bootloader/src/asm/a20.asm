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
    call println
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
    call println
    pop si
.not_enabled:
    push si
    mov si, x16_real_msg_failed_to_enable_the_a20_line
    call println
    pop si
    mov ax, 1
    ret
.already_enabled:
    push si
    mov si, x16_real_msg_the_a20_line_already_enabled
    call println
    pop si
    jmp .enabled
.enabled_using_the_bios:
    call x16_real_check_the_a20_line
    je .try_enable_using_the_keyboard_controller
    push si
    mov si, x16_real_msg_the_a20_line_already_enabled
    call println
    pop si
    jmp .enabled
.not_supported_using_the_bios:
    push si
    mov si, x16_real_msg_the_a20_line_enabling_is_not_supported_using_the_bios
    call println
    pop si
    jmp .try_enable_using_the_keyboard_controller
.could_not_get_status_using_the_bios:
    push si
    mov si, x16_real_msg_could_not_get_the_a20_line_status_using_the_bios
    call println
    pop si
    jmp .try_enable_using_the_keyboard_controller
.already_enabled_using_the_bios:
    call x16_real_check_the_a20_line
    je .try_enable_using_the_keyboard_controller
    jmp .already_enabled
.enabled_using_the_keyboard_controller:
    push si
    mov si, x16_real_msg_the_a20_line_is_enabled_using_the_keyboard_controller
    call println
    pop si
    jmp .enabled
.enabled_using_the_fast_gate:
    call x16_real_check_the_a20_line
    je .not_enabled_using_the_fast_gate
    push si
    mov si, x16_real_msg_the_a20_line_is_enabled_using_the_fast_gate
    call println
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

x16_real_msg_trying_to_enable_the_a20_line: db 'Trying to enable the A20 line...', 0
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