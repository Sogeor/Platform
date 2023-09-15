#include "lifecycle.h"

__asm__(".code16gcc");

void lifecycle() {
    print_adapter(DUMPING_NUMBER_OF_READ_SECTORS);
    println_adapter(util_uint32_to_str(number_of_sectors, 10));
    get_vbe_controller_info(); // Получение информации о контроллере VBE.
    select_optimal_vbe_mode_info(); // Выбор оптимального режима VBE.
    print_adapter("selected mode width: ");
    println_adapter(util_uint32_to_str(vbe_current_mode_info->width, 10));
    print_adapter("selected mode height: ");
    println_adapter(util_uint32_to_str(vbe_current_mode_info->height, 10));
    enter_pmode(); // Переход в защищённый режим.
    pmode_clear_screen();
    pmode_println("welcome to protected mode :D");
}