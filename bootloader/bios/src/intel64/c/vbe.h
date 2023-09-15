#pragma once

#include "stddef.h"
#include "stdint.h"
#include "injector.h"
#include "utils.h"

typedef struct vbe_real_ptr_s {
    uint16_t segment;
    uint16_t offset;
} __attribute__((packed)) vbe_real_ptr_t;

typedef struct vbe_pmode_ptr_s {
    uint16_t selector;
    uint16_t offset;
} __attribute__((packed)) vbe_pmode_ptr_t;

typedef struct vbe_mode_info_s {
    uint16_t attributes;
    uint8_t window_a_attributes;
    uint8_t window_b_attributes;
    uint16_t window_granularity;
    uint16_t window_size;
    uint16_t window_a_segment;
    uint16_t window_b_segment;
    vbe_real_ptr_t window_function_ptr;
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
    int8_t vbe_signature[4];
    uint16_t vbe_version;
    vbe_pmode_ptr_t oem_string_ptr;
    uint32_t capabilities;
//    vbe_pmode_ptr_t video_modes_ptr;
    uint32_t video_modes_ptr;
    uint16_t number_of_memory_blocks;
    uint16_t oem_software_revision;
    vbe_pmode_ptr_t oem_vendor_name_ptr;
    vbe_pmode_ptr_t oem_product_name_ptr;
    vbe_pmode_ptr_t oem_product_revision_ptr;
    uint8_t reserved[222];
    uint8_t oem_data[256];
} __attribute__((packed)) vbe_controller_info_t;

extern void get_vbe_controller_info();

void select_optimal_vbe_mode_info();

extern vbe_controller_info_t vbe_controller_info;

extern vbe_mode_info_t *vbe_current_mode_info;