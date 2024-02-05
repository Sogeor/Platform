#ifndef BOOTMBR_SSGFS_H
#define BOOTMBR_SSGFS_H

#include <stdint.h>
#include <stdbool.h>

#include "dap.h"

struct ssgfs_dir_desc
{
    uint8_t desc_type; // always 0x1
    uint32_t parent_ptr; // pointer to parent directory descriptor
    uint32_t dest_num; // number of directory entry descriptors
    uint32_t dest_ptr; // pointer to list of destination descriptors
    uint16_t name_len;
    uint8_t name_data[];
} __attribute__((packed));

struct ssgfs_file_desc
{
    uint8_t desc_type; // always 0x2
    uint32_t parent_ptr; // pointer to parent directory descriptor
    uint32_t data_len;
    uint32_t data_ptr;
    uint16_t name_len;
    uint8_t name_data[];
} __attribute__((packed));

struct ssgfs_link_desc
{
    uint8_t desc_type; // always 0x4
    uint32_t parent_ptr; // pointer to parent directory descriptor
    uint32_t dest_ptr; // pointer to destination descriptor
    uint16_t name_len;
    uint8_t name_data[];
} __attribute__((packed));

#define SSGFS_ROOT_DIR_OFFSET 1024 * 1024 // 1 megabyte
#define SSGFS_DESC_TYPE_NONE 0x0
#define SSGFS_DESC_TYPE_DIR 0x1
#define SSGFS_DESC_TYPE_FILE 0x2
#define SSGFS_DESC_TYPE_LINK 0x4

extern struct ssgfs_dir_desc ssgfs_root;

struct ssgfs_path
{
    uint32_t index_num; // number of indexes of descriptors
    uint32_t indexes[]; // list of indexes of descriptors
} __attribute__((packed));

#define SSGFS_PATH_DIR_SEPARATOR '/'

enum ssgfs_mount_result
{
    SSGFS_MOUNT_RESULT_SUCCESSFUL,
    SSGFS_MOUNT_RESULT_CORRUPTED
};

ssgfs_mount_result ssgfs_mount();

enum ssgfs_find_dir_result
{
    SSGFS_FIND_DIR_SUCCESSFUL,
    SSGFS_FIND_DIR_NOT_FOUND,
    SSGFS_FIND_DIR_NOT_DIR
};

ssgfs_find_dir_result ssgfs_find_dir(struct ssgfs_dir_desc *parent_desc, uint16_t name_len, char *name,
                                     struct ssgfs_dir_desc *result_desc);

enum ssgfs_encode_path_result
{
    SSGFS_ENCODE_PATH_SUCCESSFUL,
    SSGFS_ENCODE_PATH_NOT_FOUND,
    SSGFS_ENCODE_PATH_INVALID
};

ssgfs_encode_path_result ssgfs_encode_path(const char *path, struct ssgfs_path *ssgfs_path);

#endif //BOOTMBR_SSGFS_H
