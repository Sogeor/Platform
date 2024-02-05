#include "iso9660.h"

iso9660_status iso9660_mount(uint8_t disk, uint32_t (*read_func)(uint8_t disk, uint32_t offset, uint32_t size),
                             struct iso9660_entry_desc *root_entry)
{
    struct iso9660_boot_volume_desc *boot_volume_desc = read_func(disk, ISO9660_SYSTEM_AREA_SIZE, ISO9660_VOLUME_SIZE);
    if (!strcmp(boot_volume_desc->id, ISO9660_VOLUME_ID))
    {
        return ISO9660_STATUS_MISSING;
    }
    if (boot_volume_desc->type != ISO9660_VOLUME_TYPE_BOOT)
    {
        return ISO9660_STATUS_CORRUPTED;
    }
    if (boot_volume_desc->version != ISO9660_VOLUME_DESC_VERSION)
    {
        return ISO9660_STATUS_UNSUPPORTED;
    }
    struct iso9660_boot_volume_desc *primary_volume_desc = read_func(disk, ISO9660_SYSTEM_AREA_SIZE, ISO9660_VOLUME_SIZE);
    return ISO9660_STATUS_MISSING;
}