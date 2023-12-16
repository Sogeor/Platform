#pragma once

#include <stdint.h>

#include "build.h"
#include "pmode.h"

#define VBE_LIST_OF_MODE_NUMBER_TERMINATION 0xFFFF

#define VBE_FUNC_RESULT_AL_SUPPORTED 0x4F
#define VBE_FUNC_RESULT_AH_SUCCESSFUL 0
#define VBE_FUNC_RESULT_AH_FAILED 1
#define VBE_FUNC_RESULT_AH_INVALID_HARDWARE 0x2
#define VBE_FUNC_RESULT_AH_INVALID_MODE 0x3

typedef uint16_t __vbe_result_t;

typedef struct __vbe_controller_info_s
{
    signed char vbe_signature[4];
    uint16_t vbe_version;
    rmode_ptr_t oem_string_ptr;
    uint32_t capabilities;
    rmode_ptr_t list_of_mode_numbers_ptr;
    uint16_t number_of_memory_blocks;
    uint16_t oem_software_revision;
    rmode_ptr_t oem_vendor_name_ptr;
    rmode_ptr_t oem_product_name_ptr;
    rmode_ptr_t oem_product_revision_ptr;
    uint8_t reserved[222];
    uint8_t oem_data[256];
} __attribute__((packed)) __vbe_controller_info_t;

typedef struct __vbe_mode_info_s
{
    uint16_t attributes;
    uint8_t window_a_attributes;
    uint8_t window_b_attributes;
    uint16_t window_granularity;
    uint16_t window_size;
    uint16_t window_a_segment;
    uint16_t window_b_segment;
    rmode_ptr_t window_function_ptr;
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
} __attribute__((packed)) __vbe_mode_info_t;

typedef struct __vbe_mode_brief_s
{
    uint16_t number;
    uint16_t width;
    uint16_t height;
    uint16_t buffer_size;
} __attribute__((packed)) __vbe_mode_brief_t;

extern __vbe_controller_info_t __vbe_controller_info;

extern __vbe_mode_info_t __vbe_mode_info;

extern __vbe_mode_brief_t __vbe_mode_brief;

typedef struct vbe_result_s
{
    uint8_t al;
    uint8_t ah;
} __attribute__((packed)) vbe_result_t;

extern __vbe_result_t __vbe_get_controller_info__();

extern __vbe_result_t __vbe_get_mode_info__();

extern __vbe_result_t __vbe_set_mode__();

vbe_result_t vbe_result_compute(__vbe_result_t result);

__vbe_result_t vbe_get_controller_info();

__vbe_result_t vbe_get_mode_info(uint16_t mode_number);

__vbe_result_t vbe_set_mode(uint16_t mode_number);

vbe_result_t vbe_select_mode_info();

vbe_result_t vbe_select_mode();