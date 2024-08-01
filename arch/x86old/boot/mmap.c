#include "mmap.h"

__asm(".code16gcc");

__attribute((section(".mmap")))
void mmap_make(void)
{
    mmap_query();
    if (mmap_entries == MMAP_NO_ENTRIES)
    {
        msec_println(mmap_auto_query_no_entries_msg);
        msec_die();
    }
    msec_die();
    if (mmap_normalize()) return;
    msec_println(mmap_auto_normalize_failed_msg);
    msec_die();
}

__attribute((section(".mmap")))
void mmap_query(void)
{
    if (mmap_entries != MMAP_NO_ENTRIES) return;
    struct mmap_entry *entry = mmap;
    uint32_t sign__;
    uint32_t desc__ = 0;
    uint32_t size__;
    do
    {
        __asm("int $0x15" :
            "=a"(sign__), "=b"(desc__), "=c"(size__) :
            "a"(0xE820), "b"(desc__), "c"(MMAP_ENTRY_SIZE_ACPI), "d"(MMAP_SIGN), "D"(entry));
        if (sign__ != MMAP_SIGN)
        {
            msec_println(mmap_query_invalid_sign_msg);
            msec_die();
        }
        if (size__ >= MMAP_ENTRY_SIZE_ACPI && (entry->acpi ^ MMAP_ENTRY_ACPI_CORRECT)) continue;
        ++entry;
        ++mmap_entries;
    } while (desc__ != 0 && mmap_entries < MMAP_SIZE && mmap_entries < 2); // wtf...
}

__attribute((section(".mmap")))
bool mmap_normalize(void)
{
    // todo: memory map normalize algorithm
    return true;
}
