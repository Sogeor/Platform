%include "include.asm"

extern launch

global halt
global print
global println
global read_sectors

section .injector ; Определение секции для линковщика.
bits 16 ; Определение разрядности для компилятора и линковщика.

times 90 db 0 ; Резервирование данных для BIOS.
jmp 0x0:inject ; Сброс предустановленного сегмента на начальный.

inject:
    mov [disk], dl ; Сохранение загрузочной информации.
    xor cx, cx ; Подготовка общих регистров.
    xor si, si
    xor di, di
    mov bp, cx ; Подготовка стековых регистров.
    mov sp, inject
    mov ds, cx ; Подготовка сегментных регистров.
    mov es, cx
    mov fs, cx
    mov gs, cx
    mov ss, cx
    mov si, READING_SECTORS_FROM_DISK_TO_MEMORY ; Считывание секторов с диска в память.
    call println
    mov ax, NUMBER_OF_SECTORS
    mov bx, launch
    mov edx, 1
    call read_sectors
    mov si, TRANSFER_OF_CONTROL_TO_READ_SECTORS ; Передача управления считанным секторам.
    call println
    jmp launch

halt: ; Циклическая остановка процессора.
    hlt
    jmp halt

print: ; Печать завершённой нулём строки на экран с помощью вызова прерывания BIOS.
    push ax
    push si
    pushf
    mov ah, 0xE
.loop:
    lodsb
    cmp al, 0
    je .ret ; Выход из цикла без печати завершающего нуля.
    int 0x10
    jmp .loop
.ret:
    popf
    pop si
    pop ax
    ret

println: ; Печать завершённой нулём строки на экран с переходом курсора на новую с помощью вызова прерывания BIOS.
    call print
    push si
    mov si, LINE_SEPARATOR
    call print
    pop si
    ret

read_sectors: ; Считывание секторов с диска в память с помощью вызова прерывания BIOS и пакета доступа к диску.
    push si
    pushf
.check:
    cmp ax, 127
    ja .loop ; Переход к циклу для считывания только 127 секторов с диска в память единовременно.
    call .reading
    jmp .ret
.loop:
    push ax
    mov ax, 127
    call .reading
    pop ax
    sub ax, 127
    add cx, 127 * 512 / 16
    add edx, 127
    jmp .check ; Переход к проверке для повторной попытки считывания 127 или меньше секторов с диска в память.
.reading: ; Считывание секторов с диска в память с помощью вызова прерывания BIOS и пакета доступа к диску.
    mov [dap_number_of_sectors], ax
    mov [dap_buffer_offset], bx
    mov [dap_buffer_segment], cx
    mov [dap_lba_lower], edx
    mov ah, 0x42
    mov dl, [disk]
    mov si, dap
    int 0x13
    jc halt ; Переход к циклической остановке процессора при ошибке чтения диска.
    ret
.ret:
    popf
    pop si
    ret

disk db 0 ; Резервирование памяти под информацию о диске.

dap: ; Резервирование памяти под пакет доступа к диску.
dap_size db 16
dap_reserved db 0
dap_number_of_sectors dw 0
dap_buffer_offset dw 0
dap_buffer_segment dw 0
dap_lba_lower dd 0
dap_lba_upper dd 0

LINE_SEPARATOR: db 13, 10, 0 ; Запись сообщений в память.
READING_SECTORS_FROM_DISK_TO_MEMORY: db 'Reading sectors from disk to memory...', 0
TRANSFER_OF_CONTROL_TO_READ_SECTORS: db 'Transfer of control to read sectors...', 0

times 510 - ($ - $$) db 0 ; Заполнение памяти недостающими байтами для достижения корректной длины загрузочного сектора.
dw 0xAA55 ; Запись метки загрузочного сектора в память.