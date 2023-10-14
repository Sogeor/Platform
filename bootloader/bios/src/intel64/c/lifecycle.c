#include "lifecycle.h"

__asm__(".code16gcc");

void lifecycle() {
    lc_vbe_load();
    x_println("Entering to the protected mode...");
//    enter_pmode(); // Переход в защищённый режим.
//    __asm__(".code32");
    lc_pmode();
}

void lc_vbe_load() {
    x_println("Getting the VBE controller info...");
    vbe_func_result_t result = vbe_get_controller_info(); // Получение информации о контроллере VBE.
    if (result.al != VBE_FUNC_RESULT_AL_SUPPORTED) {
        x_println("Getting the VBE controller info isn't supported");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_FAILED) {
        x_println("Failed to get the VBE controller info");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_INVALID_HARDWARE) {
        x_println("Invalid hardware configuration");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_INVALID_MODE) {
        x_println("Invalid video mode");
        halt();
    }
    x_println("Selecting the video mode info...");
    result = vbe_select_mode_info(); // Получение информации об оптимальном видеорежиме.
    if (result.al != VBE_FUNC_RESULT_AL_SUPPORTED) {
        x_println("Selecting the video mode info isn't supported");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_FAILED) {
        x_println("Failed to select the video mode info");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_INVALID_HARDWARE) {
        x_println("Invalid hardware configuration");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_INVALID_MODE) {
        x_println("Invalid video mode");
        halt();
    }
}

__asm__(".code32");

void lc_pmode() {
    enter_pmode(); // Переход в защищённый режим.
    pmode_clear_screen();
    pmode_println("welcome to protected mode :D");
    lc_vbe_init();
    pmode_println("ky e pta");
}

void lc_vbe_init() {
    pmode_println("Setting the video mode...");
    vbe_func_result_t result = vbe_select_mode(vbe_mode_summary.number); // Установка видеорежима.
    if (result.al != VBE_FUNC_RESULT_AL_SUPPORTED) {
        pmode_println("Setting the video mode isn't supported");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_FAILED) {
        pmode_println("Failed to set the video mode");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_INVALID_HARDWARE) {
        pmode_println("Invalid hardware configuration");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_INVALID_MODE) {
        pmode_println("Invalid video mode");
        halt();
    }
}