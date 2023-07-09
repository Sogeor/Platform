entry:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov sp, entry
    mov [disk], dl
    cld
    mov ax, INCLUDE_NUMBER_OF_LATE_SECTORS
    mov bx, entrance
    xor cx, cx
    mov edx, 1
    mov si, LATE_SECTORS_READING
    call println
    call read_sectors
    jc .error
    mov si, JUMPING_TO_LATE_SECTORS
    call println
    jmp entrance
.error:
    mov si, LATE_SECTORS_READING_ERROR
    call println
.loop:
    hlt
    jmp .loop

LATE_SECTORS_READING: db 'Reading the late sectors...', 0
LATE_SECTORS_READING_ERROR: db 'Unable to read the late sectors', 0
JUMPING_TO_LATE_SECTORS: db 'Jumping to the late sectors...', 0