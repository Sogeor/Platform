section .stack

%ifndef BOOT_STACK_SIZE
%define BOOT_STACK_SIZE 512
%endif ; BOOT_SIZE

global stack_end
stack_end:

times BOOT_STACK_SIZE db 0

global stack_base
stack_base:
