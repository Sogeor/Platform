extern bsec_halt
extern bsec_die
extern a20_enable
extern gdt_load
extern mmap_make
extern pm_enter
extern pm_leave
extern main

global msec_main
global msec_halt
global msec_die
global msec_print
global msec_println
global msec_disk

bits 16
section .msec

msec_main:
    mov [msec_disk], dl
    call a20_enable
    call gdt_load
;    call mmap_make
;    call msec_die
    call pm_enter

bits 32

    call main
    call pm_leave

bits 16

    mov si, msec_main_msg
    call msec_println
    ret

msec_halt:
    jmp bsec_halt

msec_die:
    jmp bsec_die

msec_print:
    push ax
    push si
    pushf
    mov ah, 0xE
.loop:
    lodsb
    cmp al, 0 ; msec_print_null
    je .free
    int 0x10
    jmp .loop
.free:
    popf
    pop si
    pop ax
    ret

msec_println:
    call msec_print
    push si
    mov si, msec_println_msg
    call msec_print
    pop si
    ret

msec_disk: db 0

msec_print_null: db 0
msec_print_crlf: db 13, 10

msec_println_msg: db 13, 10, 0

msec_main_msg: db "Hello world!", 0

; Алгоритм v2:
; 1) Включить линию A20 ✓
; 2) Настроить GDT ✓
; 3) Создать карту памяти ✓
; 4) Перейти в защищённый режим
; 5) Подготовить консольный интерфейс
; 6) Поиск файлов ядра
; 7) Загрузка ядра в память
; 8) Передача управления ядру
