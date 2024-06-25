org 0x7C00
bits 16

%if MANAGER_SIZE > 59
%error "The manager size must be less than or equal to 59"
%endif
%if MANAGER_SIZE < 1
%error "The manager size must be more than or equal to 1"
%endif

jmp 0:start
start:
    mov [disk], dl

    xor ax, ax
    mov ds, ax
    mov es, ax

    mov bp, 0x7BFF
    mov ss, ax
    mov sp, bp

    mov fs, ax
    mov gs, ax

    mov ah, 0x42
    mov si, dap
    int 13h
    jc .die
    test ah, ah
    jnz .die

    mov dl, [disk]
    jmp 0x500
.die:
    mov ah, 0xE
    mov bx, 0
    mov cx, 22
    mov si, .msg
.print:
    lodsb
    int 10h
    loop .print
.halt:
    hlt
    jmp .halt
.msg: db "Failed to load manager"

disk: db 0

dap:
dap_size: db 16
dap_reserved: db 0
dap_number: dw MANAGER_SIZE
dap_offset: dw 0
dap_segment: dw 0x500 / 16
dap_lba_low: dd 1
dap_lba_up: dw 0
dap_lba_extra: dw 0

times 440 - ($ - $$) db 0
times 6 db 0

partition_1: times 16 db 0
partition_2: times 16 db 0
partition_3: times 16 db 0
partition_4: times 16 db 0

dw 0xAA55
