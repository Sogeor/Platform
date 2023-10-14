#pragma once

#include <stdint.h>

#include "injector.h"
#include "utils.h"

#define VBE_MODE_NUMBER_LIST_TERMINATION 0xFFFF

#define VBE_FUNC_RESULT_AL_SUPPORTED 0x4F
#define VBE_FUNC_RESULT_AH_SUCCESSFUL 0x0
#define VBE_FUNC_RESULT_AH_FAILED 0x1
#define VBE_FUNC_RESULT_AH_INVALID_HARDWARE 0x2
#define VBE_FUNC_RESULT_AH_INVALID_MODE 0x3

typedef struct vbe_func_result_s {
    uint8_t al;
    uint8_t ah;
} __attribute__((packed)) vbe_func_result_t;

typedef struct vbe_mode_summary_s {
    uint16_t number;
    uint16_t width;
    uint16_t height;
} __attribute__((packed)) vbe_mode_summary_t;

typedef struct vbe_mode_info_s {
    uint16_t attributes;
    uint8_t window_a_attributes;
    uint8_t window_b_attributes;
    uint16_t window_granularity;
    uint16_t window_size;
    uint16_t window_a_segment;
    uint16_t window_b_segment;
    p_ptr_t window_function_ptr;
    uint16_t number_of_bytes_in_line;
    uint16_t width;
    uint16_t height;
    uint8_t pixel_width;
    uint8_t pixel_height;
    uint8_t number_of_planes;
    uint8_t number_of_bits_in_pixel;
    uint8_t number_of_banks;
    uint8_t memory_model_type;
    uint8_t bank_size;
    uint8_t number_of_image_pages;
    uint8_t reserved_0;
    uint8_t number_of_bits_in_direct_color_red_mask;
    uint8_t position_of_lsb_of_direct_color_red_mask;
    uint8_t number_of_bits_in_direct_color_green_mask;
    uint8_t position_of_lsb_of_direct_color_green_mask;
    uint8_t number_of_bits_in_direct_color_blue_mask;
    uint8_t position_of_lsb_of_direct_color_blue_mask;
    uint8_t number_of_bits_in_direct_color_reserved_mask;
    uint8_t position_of_lsb_of_direct_color_reserved_mask;
    uint8_t direct_color_mode_attributes;
    uint32_t framebuffer_physical_address;
    uint32_t reserved_1;
    uint16_t reserved_2;
    uint8_t reserved_3[206]; // TODO: Mandatory information for VBE 3.0 and above
} __attribute__((packed)) vbe_mode_info_t;

typedef struct vbe_controller_info_s {
    signed char vbe_signature[4];
    uint16_t vbe_version;
    r_ptr_t oem_string_ptr;
    uint32_t capabilities;
    r_ptr_t list_of_mode_numbers_ptr;
    uint16_t number_of_memory_blocks;
    uint16_t oem_software_revision;
    r_ptr_t oem_vendor_name_ptr;
    r_ptr_t oem_product_name_ptr;
    r_ptr_t oem_product_revision_ptr;
    uint8_t reserved[222];
    uint8_t oem_data[256];
} __attribute__((packed)) vbe_controller_info_t;

extern uint16_t vbe_update_controller_info();

extern uint16_t vbe_update_mode_info();

extern uint16_t vbe_update_mode();

vbe_func_result_t vbe_get_controller_info();

vbe_func_result_t vbe_get_mode_info(uint16_t mode_number);

vbe_func_result_t vbe_select_mode_info();

vbe_func_result_t vbe_select_mode(uint16_t mode_number);

extern vbe_controller_info_t vbe_controller_info;

extern vbe_mode_info_t vbe_mode_info;

extern vbe_mode_summary_t vbe_mode_summary;