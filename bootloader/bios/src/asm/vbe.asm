global vbe_info
global vbe_info_signature
global vbe_info_version
global vbe_info_oem_string_selector
global vbe_info_oem_string_offset
global vbe_info_capabilities
global vbe_info_video_mode_selector
global vbe_info_video_mode_offset
global vbe_info_number_of_memory_blocks
global vbe_info_oem_software_revision
global vbe_info_oem_vendor_name_selector
global vbe_info_oem_vendor_name_offset
global vbe_info_oem_product_name_selector
global vbe_info_oem_product_name_offset
global vbe_info_oem_product_revision_selector
global vbe_info_oem_product_revision_offset
global vbe_info_reserved
global vbe_info_oem_data

bits 16
section .text
align 4, db 0

vbe_info:
vbe_info_signature: db "VESA"
vbe_info_version: dw 0x300
vbe_info_oem_string_selector: dd 0
vbe_info_oem_string_offset: dd 0
vbe_info_capabilities: dd 0
vbe_info_video_mode_selector: dw 0
vbe_info_video_mode_offset: dw 0
vbe_info_number_of_memory_blocks: dw 0
vbe_info_oem_software_revision: dw 0
vbe_info_oem_vendor_name_selector: dw 0
vbe_info_oem_vendor_name_offset: dw 0
vbe_info_oem_product_name_selector: dw 0
vbe_info_oem_product_name_offset: dw 0
vbe_info_oem_product_revision_selector: dw 0
vbe_info_oem_product_revision_offset: dw 0
vbe_info_reserved: times 222 db 0
vbe_info_oem_data: times 256 db 0

global vbe_mode_info
vbe_mode_info:
    dw 0
    dw 0
    dw 0
    dw 0
    dd 0
    dd 0
global vbe_info_pitch
vbe_mode_info_pitch:
    dw 0
global vbe_info_width
vbe_mode_info_width:
    dw 0
global vbe_info_height
vbe_mode_info_height:
    dw 0
    dw 0
    db 0
global vbe_info_bpp
vbe_mode_info_bpp:
    db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
          db 0
global vbe_info_fbaddr
vbe_mode_info_fbaddr:
          dd 0
          dd 0
          dw 0
          times 206 db 0