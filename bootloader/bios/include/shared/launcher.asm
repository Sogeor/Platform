extern halt
extern println
extern prepare_a20_line
extern prepare_gdt
extern lifecycle

global launch

section .launcher ; Определение секции для линковщика.
bits 16 ; Определение разрядности для компилятора и линковщика.

launch:
    call prepare_a20_line ; Подготовка линии A20.
    call prepare_gdt ; Подготовка таблицы глобальных дескрипторов.
    mov si, TRANSFER_OF_CONTROL_TO_LIFECYCLE
    call println
    jmp lifecycle ; Передача управления основному жизненному циклу загрузчика.

TRANSFER_OF_CONTROL_TO_LIFECYCLE: db 'Transfer of control to the lifecycle...', 0