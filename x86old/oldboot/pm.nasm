section .pm

bits 16
extern boot_die
extern nmi_disable
extern gdt_load
global pm_main
pm_main:
    cli ; todo: move it to boot_main
    call nmi_disable ; todo: move it to boot_main
    call gdt_load ; todo: move it to boot_main
    ; todo: enter to pm
    ; todo: load kernel to memory
    ; todo: transfer control to kernel
    ret
