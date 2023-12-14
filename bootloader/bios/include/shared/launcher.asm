extern halt
extern println
extern a20_line_prepare
extern gdtr
extern lifecycle

global launch

section .launcher
bits 16

launch:
    call a20_line_prepare ; Подготовка линии A20.
    mov si, GDT_LOAD
    call println
    lgdt [gdtr] ; Загрузка таблицы глобальных дескрипторов.
    mov si, TRANSFER_OF_CONTROL_TO_LIFECYCLE
    call println
    jmp lifecycle ; Передача управления основному жизненному циклу загрузчика.

GDT_LOAD: db 'Loading the GDT...', 0
TRANSFER_OF_CONTROL_TO_LIFECYCLE: db 'Transfer of control to the lifecycle...', 0