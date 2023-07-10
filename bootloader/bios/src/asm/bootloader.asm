bits 16

section .text

%include "include.asm"

times 90 db 0

jmp 0x0:entry

%include "bootloader/early.asm"

%include "bootloader/print.asm"

%include "bootloader/dap.asm"

times 510 - ($ - $$) db 0

dw 0xAA55