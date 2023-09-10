extern halt
extern println
extern prepare_a20_line
extern lifecycle

global launch

section .launcher ; Определение секции для линковщика.
bits 16 ; Определение разрядности для компилятора и линковщика.

launch:
    mov si, WELCOME_BRO
    call println
    call prepare_a20_line ; Подготовка линии A20.
    jmp lifecycle

WELCOME_BRO: db 'Welcome, Bro!', 0