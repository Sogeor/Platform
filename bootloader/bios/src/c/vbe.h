#pragma once

#include "stdint.h"
#include "vector"

__asm__(".code16gcc")

typedef struct vbe_ptr_s {
    uint16_t selector;
    uint16_t offset;
} __attribute__((packed)) vbe_ptr_t;

typedef struct vbe_info_s {
    int8_t vbe_signature[4];
    uint16_t vbe_version;
    vbe_ptr_t oem_string_ptr;
    uint32_t capabilities;
    vbe_ptr_t video_mode_ptr;
    uint16_t number_of_memory_blocks;
    uint16_t oem_software_revision;
    vbe_ptr_t oem_vendor_name_ptr;
    vbe_ptr_t oem_product_name_ptr;
    vbe_ptr_t oem_product_revision_ptr;
    uint8_t reserved[222];
    uint8_t oem_data[256];
} __attribute__((packed)) vbe_info_t;

namespace fluent {

    typedef struct vbe_std_info_s {
        const char *signature;
        uint16_t *version;
        uint32_t *capabilities;
        bool dac_width_switchable;
        bool controller_vga_compatible;
        uint16_t *number_of_memory_blocks;
        uint16_t (*video_modes)[];
    } __attribute__((packed)) vbe_std_info_t;

    typedef struct vbe_oem_info_s {
        const char *oem_string;
        uint16_t *oem_software_revision;
        const char *vendor_name;
        const char *product_name;
        const char *product_revision;
        uint8_t (*oem_data)[256];
    } __attribute__((packed)) vbe_oem_info_t;

    typedef struct vbe_info_s {
        vbe_std_info_t std_info;
        vbe_oem_info_t oem_info;
        uint8_t (*reserved)[222];
    } __attribute__((packed)) vbe_info_t;
}

typedef struct fluent_vbe_info_s {
    const char *vbe_signature;
    uint16_t vbe_version;
    const char *oem_string;
    uint32_t capabilities;
    uint16_t video_modes[4];
    uint16_t number_of_memory_blocks;
    uint16_t oem_software_revision;
    uint32_t oem_vendor_name_ptr;
    uint32_t oem_product_name_ptr;
    uint32_t oem_product_revision_ptr;
    uint8_t reserved[222];
    uint8_t oem_data[256];
} __attribute__((packed)) fluent_vbe_info_t;

void a() {
    fluent::vbe_info_t vbe_info;
}

typedef struct vbe_mode_info_s {
    uint16_t attributes;
    uint8_t window_a_attributes;
    uint8_t window_b_attributes;
    uint16_t window_granularity;
    uint16_t window_size;
    uint16_t segment_a_address;
    uint16_t segment_b_address;
    uint32_t window_function;
} __attribute__((packed)) vbe_mode_info_t;

struct vbe_mode_info_s_old {
    uint16_t attributes;        // deprecated, only bit 7 should be of interest to you, and it indicates the mode supports a linear frame buffer.
    uint8_t window_a;            // deprecated
    uint8_t window_b;            // deprecated
    uint16_t granularity;        // deprecated; used while calculating bank numbers
    uint16_t window_size;
    uint16_t segment_a;
    uint16_t segment_b;
    uint32_t win_func_ptr;        // deprecated; used to switch banks from protected mode without returning to real mode
    uint16_t pitch;            // number of bytes per horizontal line
    uint16_t width;            // width in pixels
    uint16_t height;            // height in pixels
    uint8_t w_char;            // unused...
    uint8_t y_char;            // ...
    uint8_t planes;
    uint8_t bpp;            // bits per pixel in this mode
    uint8_t banks;            // deprecated; total number of banks in this mode
    uint8_t memory_model;
    uint8_t bank_size;        // deprecated; size of a bank, almost always 64 KB but may be 16 KB...
    uint8_t image_pages;
    uint8_t reserved0;

    uint8_t red_mask;
    uint8_t red_position;
    uint8_t green_mask;
    uint8_t green_position;
    uint8_t blue_mask;
    uint8_t blue_position;
    uint8_t reserved_mask;
    uint8_t reserved_position;
    uint8_t direct_color_attributes;

    uint32_t framebuffer;        // physical address of the linear frame buffer; write here to draw to the screen
    uint32_t off_screen_mem_off;
    uint16_t off_screen_mem_size;    // size of memory in the framebuffer but not being displayed on the screen
    uint8_t reserved1[206];
} __attribute__ ((packed));