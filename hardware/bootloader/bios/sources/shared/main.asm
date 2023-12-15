extern __halt__
extern __a20_line_prepare__
extern __gdtr
extern __lifecycle__

global __main__

section .main
bits 16

__main__:
    call __a20_line_prepare__
    lgdt [__gdtr]
    call __lifecycle__
    jmp __halt__