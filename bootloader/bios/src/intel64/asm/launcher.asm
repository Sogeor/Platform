extern halt
extern println
extern lifecycle

global launch

section .launcher ; Определение секции для линковщика.
bits 16 ; Определение разрядности для компилятора и линковщика.

launch:
    mov si, WELCOME_BRO
    call println
    jmp lifecycle

WELCOME_BRO: db 'Welcome, Bro!', 0