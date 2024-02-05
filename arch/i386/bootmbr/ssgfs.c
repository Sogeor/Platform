#include "ssgfs.h"

__asm(".code16")

ssgfs_mount_result ssgfs_mount()
{
    dap.sec_num = (sizeof(struct ssgfs_dir_desc) + DAP_SEC_SIZE - 1) / DAP_SEC_SIZE;
    ptr_r_decompose(&ssgfs_root, &dap.mem_ptr);
    dap.lba_num = (SSGFS_ROOT_DIR_OFFSET + DAP_SEC_SIZE - 1) / DAP_SEC_SIZE;
    dap_read();
    return ssgfs_root.desc_type == SSGFS_DESC_TYPE_DIR ? SSGFS_MOUNT_RESULT_SUCCESSFUL : SSGFS_MOUNT_RESULT_CORRUPTED;
}

ssgfs_find_dir_result ssgfs_find_dir(struct ssgfs_dir_desc *parent_desc, uint16_t name_len, char *name,
                                     struct ssgfs_dir_desc *result_desc)
{
    return SSGFS_FIND_DIR_NOT_FOUND;
}

ssgfs_encode_path_result ssgfs_encode_path(const char *path, struct ssgfs_path *ssgfs_path)
{
    struct ssgfs_dir_desc current = ssgfs_root;
    bool previous_not_dir = false;
    for (uint32_t i = 0, j = 0; path[i]; ++i)
    {
        if (path[i] == SSGFS_PATH_DIR_SEPARATOR)
        {
            uint16_t name_len = i - j + 1;
            if (name_len == 1) return SSGFS_ENCODE_PATH_INVALID;
            char name[name_len];
            for (uint32_t o = j; o < i; ++o, ++j)
            {
                name[o] = path[j];
            }
            switch (ssgfs_find_dir(&current, name_len, name, &current))
            {
                case SSGFS_FIND_DIR_NOT_FOUND:
                    return SSGFS_ENCODE_PATH_NOT_FOUND;
                case SSGFS_FIND_DIR_NOT_DIR:
                    if (path[i + 1]) {

                    }
                default:
                    break;
            }
        }
    }
}
