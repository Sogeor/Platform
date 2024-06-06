#include "main.h"

__asm(".code16gcc");

int32_t main(void)
{

    die();
    gdt_desc.size = 2;
    gdt_desc.offset = (uint32_t) &gdt;
    gdt_load(&gdt_desc);
    // TODO: enter to protected mode & use balloc
    if (balloc_mount(&balloc_image) != BALLOC_CODE_SUCCESS) die();
    return balloc_unmount(&balloc_image) == BALLOC_CODE_SUCCESS ? 0 : 1;
}

struct gdt_desc gdt_desc;
uint8_t gdt[GDT_ENTRY_SIZE * 3];

#ifdef BALLOC

struct balloc_image balloc_image = {false, 0x7C00, 0x80000 - 0x7C00, NULL};

#endif
