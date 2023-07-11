extern writeln
extern disk

global prepare_drive_parameters
global drive_parameters
global drive_parameters_size
global drive_parameters_flags
global drive_parameters_number_of_cylinders
global drive_parameters_number_of_heads
global drive_parameters_number_of_sectors_per_track
global drive_parameters_number_of_sectors
global drive_parameters_number_of_bytes_per_sector

bits 16
section .text

prepare_drive_parameters:
    push ax
    push si
    mov si, PREPARING_DRIVE_PARAMETERS
    call writeln
    mov si, ASKING_DRIVE_PARAMETERS
    call writeln
    mov ah, 0x48
    mov dl, [disk]
    mov si, drive_parameters
    int 0x13
    jnc .free
.halt:
    hlt
    jmp .halt
.free:
    pop si
    pop ax
    ret

drive_parameters:
drive_parameters_size: dw 26
drive_parameters_flags: dw 0
drive_parameters_number_of_cylinders: dd 0
drive_parameters_number_of_heads: dd 0
drive_parameters_number_of_sectors_per_track: dd 0
drive_parameters_number_of_sectors: dq 0
drive_parameters_number_of_bytes_per_sector: dw 0

PREPARING_DRIVE_PARAMETERS: db 'Preparing the drive parameters...', 0
ASKING_DRIVE_PARAMETERS: db 'Asking for the drive parameters...', 0