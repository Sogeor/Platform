#include "bootloader.h"

__asm__(".code16gcc");

__attribute__((noinline)) __attribute__((regparm(3)))
void real_printchar(char ch) {
    //*((int*)0xb8000)=ch;
    __asm__ __volatile__("mov $0x0E, %%ah\n"
                         "mov %0, %%al\n"
                         "int $0x10" : : "a"(ch));
}

__attribute__((noinline)) __attribute__((regparm(3)))
void real_print(const char* str) {
    while (*str) {
        real_printchar(*str++);
    }
}

__attribute__((noinline)) __attribute__((regparm(3)))
void real_println(const char* str) {
    real_print(str);
    real_print("\r\n");
}

__attribute__((noinline)) __attribute__((regparm(3)))
void real_panic(const char* msg) {
    real_println("!!! MISHA BOOTLOADER PANIC !!!");
    real_println(msg);
    real_println("!!! CANNOT OPTIMIZE FISH !!!");

    while (1) {
        asm("hlt");
    }
}

__asm__(".code32");

void protected_printchar(char ch) {
    static int x = 0;
    static int y = 0;

    if (ch == '\n') {
        ++y;
        return;
    } else if (ch == '\r') {
        x = 0;
        return;
    }

    *((uint16_t*) 0xB8000 + y * 80 + x) = 0x0F00 | ch;
    ++x;
}

void protected_print(const char* str) {
    while (*str) {
        protected_printchar(*str++);
    }
}

void protected_println(const char* str) {
    protected_print(str);
    protected_print("\r\n");
}

void protected_panic(const char* msg) {
    protected_println("!!! MISHA BOOTLOADER PANIC !!!");
    protected_println(msg);
    protected_println("!!! CANNOT OPTIMIZE FISH !!!");

    while (1) {
        asm("hlt");
    }
}

//void bios_call(char* target, uint32_t sector) {
//    dap_num_sectors = 2048 / drive_params_bps;
//    dap_buf_offset = (uint32_t) disk_space & 0xFFFF;
//    dap_buf_segment = (uint32_t) disk_space >> 16;
//    dap_lba_lower = sector * dap_num_sectors;
//    dap_lba_upper = 0;
//    do_bios_call(BIOS_READ_DISK, 0);
//    memcpy(target, disk_space, 2048);
//}

__asm__(".code16gcc");

void bootloader_main() {
    real_println("daroy");
    //enter_protected_mode();
}