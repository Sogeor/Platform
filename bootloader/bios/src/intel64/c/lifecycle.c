#include "lifecycle.h"

__asm__(".code16gcc");

void lifecycle() {
    print_adapter(DUMPING_NUMBER_OF_READ_SECTORS);
    println_adapter(util_uint32_to_str(number_of_sectors, 10));
    enter_pmode(); // Переход в защищённый режим.
    pmode_clear_screen();
    pmode_println("welcome to protected mode :D");
}