extern println

global prepare_a20_line
global check_a20_line
global enable_a20_line_using_bios
global enable_a20_line_using_ps2_controller
global enable_a20_line_using_fast_gate
global enable_a20_line_using_io_port

bits 16
section .text

prepare_a20_line:
    push ax
    push si
    mov si, PREPARING_A20_LINE
    call println
    mov si, CHECKING_A20_LINE
    call println
    call check_a20_line
    cmp ax, 0
    jz .free
    mov si, TRYING_TO_ENABLE_A20_LINE_USING_BIOS
    call println
    call enable_a20_line_using_bios
    mov si, CHECKING_A20_LINE
    call println
    call check_a20_line
    cmp ax, 0
    jz .free
    mov si, TRYING_TO_ENABLE_A20_LINE_USING_PS2_CONTROLLER
    call println
    call enable_a20_line_using_ps2_controller
    call check_a20_line
    cmp ax, 0
    jz .free
    mov si, TRYING_TO_ENABLE_A20_LINE_USING_FAST_GATE
    call println
    call enable_a20_line_using_fast_gate
    call check_a20_line
    cmp ax, 0
    jz .free
    mov si, TRYING_TO_ENABLE_A20_LINE_USING_IO_PORT
    call println
    call enable_a20_line_using_io_port
    call check_a20_line
    cmp ax, 0
    jz .free
.halt:
    hlt
    jmp .halt
.free:
    pop si
    pop ax
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
    call .wait_1
    mov al, 0xAD
    out 0x64, al
    call .wait_1
    mov al, 0xD0
    out 0x64, al
    call .wait_2
    in al, 0x60
    push eax
    call .wait_1
    mov al, 0xD1
    out 0x64, al
    call .wait_1
    pop eax
    or al, 2
    out 0x60, al
    call .wait_1
    mov al, 0xAE
    out 0x64, al
    call .wait_1
    sti
    ret
.wait_1:
    in al, 0x64
    test al, 2
    jnz .wait_1
    ret
.wait_2:
    in al, 0x64
    test al, 1
    jz .wait_2
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

PREPARING_A20_LINE: db 'Preparing the A20 line...', 0
CHECKING_A20_LINE: db 'Checking the A20 line...', 0
TRYING_TO_ENABLE_A20_LINE_USING_BIOS: db 'Trying to enable the A20 line using the BIOS...', 0
TRYING_TO_ENABLE_A20_LINE_USING_PS2_CONTROLLER: db 'Trying to enable the A20 line using the PS/2 controller...', 0
TRYING_TO_ENABLE_A20_LINE_USING_FAST_GATE: db 'Trying to enable the A20 line using the fast gate...', 0
TRYING_TO_ENABLE_A20_LINE_USING_IO_PORT: db 'Trying to enable the A20 line using the IO port...', 0