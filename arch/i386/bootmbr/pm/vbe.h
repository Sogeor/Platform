#ifndef VBE_H
#define VBE_H

#include "../debug.h"
#include "../def.h"
#include "pm.h"
#include "ptr.h"
#include "util.h"

// #pragma region VBE_RESULT

#define VBE_RESULT_AL_SUPPORTED 0x4F

#define VBE_RESULT_AH_DONE 0
#define VBE_RESULT_AH_FAIL 1
#define VBE_RESULT_AH_INVALID_HARDWARE 2
#define VBE_RESULT_AH_INVALID_MODE 3

typedef u16_t vbe_result_t;
typedef struct vbe_result_table_s
{
    u8_t al;
    u8_t ah;
} __attribute__((packed)) vbe_result_table_t;

__attribute__((unused))
void __vbe_result_parse(vbe_result_t result, vbe_result_table_t *result_table);
__attribute__((unused))
vbe_result_t __vbe_result_compute(vbe_result_table_t *result_table);

// #pragma endregion VBE_RESULT

// #pragma region VBE_CONTROLLER_INFO

#define VBE_CONTROLLER_INFO_MODE_NUMBERS_END 0xFFFF

typedef struct vbe_controller_info_s
{
    signed char vbe_signature[4];
    u16_t vbe_version;
    ptr_table_t oem_string_ptr;
    u32_t capabilities;
    ptr_table_t mode_numbers_ptr;
    u16_t number_of_memory_blocks;
    u16_t oem_software_revision;
    ptr_table_t oem_vendor_name_ptr;
    ptr_table_t oem_product_name_ptr;
    ptr_table_t oem_product_revision_ptr;
    u8_t reserved[222];
    u8_t oem_data[256];
} __attribute__((packed)) vbe_controller_info_t;

extern vbe_controller_info_t __vbe_controller_info;

vbe_result_t __vbe_query_controller_info();

// #pragma endregion VBE_CONTROLLER_INFO

// #pragma region VBE_MODE

#define vbe_mode_number_t u16_t

vbe_result_t __vbe_require_mode(vbe_mode_number_t mode_number);

// #pragma endregion VBE_MODE

// #pragma region VBE_MODE_BRIEF

typedef struct vbe_mode_brief_s
{
    vbe_mode_number_t number;
    u16_t width;
    u16_t height;
    u16_t buffer_size;
} __attribute__((packed)) vbe_mode_brief_t;

extern vbe_mode_brief_t __vbe_mode_brief;

// #pragma endregion VBE_MODE_BRIEF

// #pragma region VBE_MODE_INFO

typedef struct vbe_mode_info_s
{
    u16_t attributes;
    u8_t window_a_attributes;
    u8_t window_b_attributes;
    u16_t window_granularity;
    u16_t window_size;
    u16_t window_a_segment;
    u16_t window_b_segment;
    ptr_table_t window_function_ptr;
    u16_t number_of_bytes_in_line;
    u16_t width;
    u16_t height;
    u8_t pixel_width;
    u8_t pixel_height;
    u8_t number_of_planes;
    u8_t number_of_bits_in_pixel;
    u8_t number_of_banks;
    u8_t memory_model_type;
    u8_t bank_size;
    u8_t number_of_image_pages;
    u8_t reserved_0;
    u8_t number_of_bits_in_direct_color_red_mask;
    u8_t position_of_lsb_of_direct_color_red_mask;
    u8_t number_of_bits_in_direct_color_green_mask;
    u8_t position_of_lsb_of_direct_color_green_mask;
    u8_t number_of_bits_in_direct_color_blue_mask;
    u8_t position_of_lsb_of_direct_color_blue_mask;
    u8_t number_of_bits_in_direct_color_reserved_mask;
    u8_t position_of_lsb_of_direct_color_reserved_mask;
    u8_t direct_color_mode_attributes;
    u32_t framebuffer_physical_address;
    u32_t reserved_1;
    u16_t reserved_2;
    u8_t reserved_3[206];
} __attribute__((packed)) vbe_mode_info_t;

extern vbe_mode_info_t __vbe_mode_info;

vbe_result_t __vbe_query_mode_info(vbe_mode_number_t mode_number);
vbe_result_t __vbe_select_mode_info();

// #pragma endregion VBE_MODE_INFO

#endif // VBE_H