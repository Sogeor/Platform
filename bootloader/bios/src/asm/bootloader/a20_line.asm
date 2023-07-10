global prepare_a20_line
global check_a20_line
global enable_a20_line_using_bios
global enable_a20_line_using_ps2_controller
global enable_a20_line_using_fast_gate
global enable_a20_line_using_io_port
global disable_a20_line_using_io_port

prepare_a20_line:
    push si
    mov si, PREPARING_A20_LINE
    call println
    mov si, CHECKING_A20_LINE
    call println
    call check_a20_line
    cmp ax, 0
    jz .already_enabled
    mov si, A20_LINE_IS_NOT_ENABLED
    call println
    mov si, TRYING_TO_ENABLE_A20_LINE_USING_BIOS
    call println
    call enable_a20_line_using_bios
    cmp ax, 0
    jz .perhaps_enabled_using_bios
    cmp ax, 1
    jz .not_supported_using_bios
    cmp ax, 2
    jz .could_not_get_status_using_bios
    cmp ax, 3
    jmp .perhaps_already_enabled_using_bios
.could_not_enable_using_bios:
    mov si, TRYING_TO_ENABLE_A20_LINE_USING_PS2_CONTROLLER
    call println
    call enable_a20_line_using_ps2_controller
    call check_a20_line
    cmp ax, 0
    jz .enabled_using_ps2_controller
    mov si, A20_LINE_IS_NOT_ENABLED_USING_PS2_CONTROLLER
    call println
    mov si, TRYING_TO_ENABLE_A20_LINE_USING_FAST_GATE
    call println
    call enable_a20_line_using_fast_gate
    call check_a20_line
    cmp ax, 0
    jz .enabled_using_fast_gate
    mov si, A20_LINE_COULD_NOT_BE_ENABLED_USING_FAST_GATE
    call println
    mov si, TRYING_TO_ENABLE_A20_LINE_USING_IO_PORT
    call println
    call enable_a20_line_using_io_port
    call check_a20_line
    cmp ax, 0
    jz .enabled_using_io_port
    mov si, A20_LINE_COULD_NOT_BE_ENABLED_USING_IO_PORT
    call println
    mov si, COULD_NOT_PREPARE_A20_LINE
    call println
    jmp .free
.already_enabled:
    mov si, A20_LINE_ALREADY_ENABLED
    call println
    jmp .free
.perhaps_enabled_using_bios:
    mov si, PERHAPS_A20_LINE_IS_ENABLED_USING_BIOS
    call println
    mov si, CHECKING_A20_LINE
    call println
    call check_a20_line
    cmp ax, 0
    jnz .not_enabled_using_bios
    mov ax, 0
    mov si, A20_LINE_IS_INDEED_ENABLED_USING_BIOS
    call println
    jmp .free
.not_enabled_using_bios:
    mov si, A20_LINE_IS_NOT_ENABLED_USING_BIOS
    call println
    jmp .could_not_enable_using_bios
.not_supported_using_bios:
    mov si, A20_LINE_ENABLING_IS_NOT_SUPPORTED_USING_BIOS
    call println
    jmp .could_not_enable_using_bios
.could_not_get_status_using_bios:
    mov si, COULD_NOT_GET_A20_LINE_STATUS_USING_BIOS
    call println
    jmp .could_not_enable_using_bios
.perhaps_already_enabled_using_bios:
    mov si, PERHAPS_A20_LINE_IS_ALREADY_ENABLED_USING_BIOS
    call println
    mov si, CHECKING_A20_LINE
    call println
    call check_a20_line
    cmp ax, 0
    jnz .not_already_enabled_using_bios
    mov ax, 0
    mov si, A20_LINE_IS_INDEED_ALREADY_ENABLED_USING_BIOS
    call println
    jmp .free
.not_already_enabled_using_bios:
    mov si, A20_LINE_IS_NOT_ALREADY_ENABLED_USING_BIOS
    call println
    jmp .could_not_enable_using_bios
.enabled_using_ps2_controller:
    mov si, A20_LINE_IS_ENABLED_USING_PS2_CONTROLLER
    call println
    jmp .free
.enabled_using_fast_gate:
    mov si, A20_LINE_IS_ENABLED_USING_FAST_GATE
    call println
    jmp .free
.enabled_using_io_port:
    mov si, A20_LINE_IS_ENABLED_USING_IO_PORT
    call println
.free:
    pop si
    ret

check_a20_line:
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
    cmp byte [es:di], 0xFF
    jz .disabled
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

enable_a20_line_using_bios:
    mov ax, 0x2403
    int 0x15
    jb .not_supported
    cmp ah, 0
    jnz .not_supported
    mov ax, 0x2402
    int 0x15
    jb .could_not_get_status
    cmp ah, 0
    jnz .could_not_get_status
    cmp al, 1
    jz .already_enabled
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

enable_a20_line_using_ps2_controller:
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

enable_a20_line_using_fast_gate:
    in al, 0x92
    test al, 2
    jnz .free
    or al, 2
    and al, 0xFE
    out 0x92, al
.free:
    ret

enable_a20_line_using_io_port:
    in al, 0xEE
    ret

disable_a20_line_using_io_port:
    out 0xEE, al
    ret

PREPARING_A20_LINE: db 'Preparing the A20 line...', 0
CHECKING_A20_LINE: db 'Checking the A20 line...', 0
A20_LINE_ALREADY_ENABLED: db 'The A20 line already enabled', 0
A20_LINE_IS_NOT_ENABLED: db 'The A20 line is not enabled', 0
TRYING_TO_ENABLE_A20_LINE_USING_BIOS: db 'Trying to enable the A20 line using the BIOS...', 0
PERHAPS_A20_LINE_IS_ENABLED_USING_BIOS: db 'Perhaps the A20 line is enabled using the BIOS', 0
A20_LINE_IS_INDEED_ENABLED_USING_BIOS: db 'The A20 line is indeed enabled using the BIOS', 0
A20_LINE_IS_NOT_ENABLED_USING_BIOS: db 'The A20 line is not enabled using the BIOS', 0
A20_LINE_ENABLING_IS_NOT_SUPPORTED_USING_BIOS: db 'The A20 line enabling is not supported using the BIOS', 0
COULD_NOT_GET_A20_LINE_STATUS_USING_BIOS: db 'Could not get the A20 line status using the BIOS', 0
PERHAPS_A20_LINE_IS_ALREADY_ENABLED_USING_BIOS: db 'Perhaps the A20 line is already enabled using the BIOS', 0
A20_LINE_IS_INDEED_ALREADY_ENABLED_USING_BIOS: db 'The A20 line is indeed already enabled using the BIOS', 0
A20_LINE_IS_NOT_ALREADY_ENABLED_USING_BIOS: db 'The A20 line is not already enabled using the BIOS', 0
TRYING_TO_ENABLE_A20_LINE_USING_PS2_CONTROLLER: db 'Trying to enable the A20 line using the PS/2 controller...', 0
A20_LINE_IS_ENABLED_USING_PS2_CONTROLLER: db 'The A20 line is enabled using the PS/2 controller', 0
A20_LINE_IS_NOT_ENABLED_USING_PS2_CONTROLLER: db 'The A20 line is not enabled using the PS/2 controller', 0
TRYING_TO_ENABLE_A20_LINE_USING_FAST_GATE: db 'Trying to enable the A20 line using the fast gate...', 0
A20_LINE_IS_ENABLED_USING_FAST_GATE: db 'The A20 line is enabled using the fast gate', 0
A20_LINE_COULD_NOT_BE_ENABLED_USING_FAST_GATE: db 'The A20 line could not be enabled using the fast gate', 0
TRYING_TO_ENABLE_A20_LINE_USING_IO_PORT: db 'Trying to enable the A20 line using the 0xEE IO port...', 0
A20_LINE_IS_ENABLED_USING_IO_PORT: db 'The A20 line is enabled using the 0xEE IO port', 0
A20_LINE_COULD_NOT_BE_ENABLED_USING_IO_PORT: db 'The A20 line could not be using the 0xEE IO port', 0
COULD_NOT_PREPARE_A20_LINE: db 'Could not prepare the A20 line', 0