#ifndef BOOT_MMAP_H
#define BOOT_MMAP_H

#include "msec.h"

#include <stdbool.h>
#include <stddef.h>

#define MMAP_SIGN 0x534D4150

#define MMAP_SIZE 128
#define MMAP_NO_ENTRIES 0

#define MMAP_ENTRY_SIZE_BASE 20
#define MMAP_ENTRY_SIZE_ACPI 24

#define MMAP_ENTRY_TYPE_USABLE 1
#define MMAP_ENTRY_TYPE_RESERVED 2
#define MMAP_ENTRY_TYPE_ACPI_RECLAIMABLE 3
#define MMAP_ENTRY_TYPE_ACPI_NVS 4
#define MMAP_ENTRY_TYPE_BAD_MEMORY 5

#define MMAP_ENTRY_ACPI_CORRECT 0x1
#define MMAP_ENTRY_ACPI_NON_VOLATILE 0x10

struct mmap_entry
{
    uint64_t base;
    uint64_t size;
    uint32_t type;
    uint32_t acpi;
} __attribute__((packed));

void mmap_make(void);
void mmap_query(void);
bool mmap_normalize(void);

extern struct mmap_entry* mmap;
uint16_t mmap_entries = MMAP_NO_ENTRIES;

const char *mmap_auto_query_no_entries_msg = "Error 0x2 occurred";
const char *mmap_auto_normalize_failed_msg = "Error 0x3 occurred";

const char *mmap_query_invalid_sign_msg = "Error 0x4 occurred";

#endif // BOOT_MMAP_H
