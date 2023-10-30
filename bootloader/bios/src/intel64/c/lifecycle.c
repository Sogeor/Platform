#include "lifecycle.h"

__asm__(".code16gcc");

void lifecycle() {
    lc_vbe_load();
    lc_pmode();
}

void lc_vbe_load() {
    inj_println("Getting the VBE controller info...");
    vbe_func_result_t result = vbe_get_controller_info(); // Получение информации о контроллере VBE.
    if (result.al != VBE_FUNC_RESULT_AL_SUPPORTED) {
        inj_println("Getting the VBE controller info isn't supported");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_FAILED) {
        inj_println("Failed to get the VBE controller info");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_INVALID_HARDWARE) {
        inj_println("Invalid hardware configuration");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_INVALID_MODE) {
        inj_println("Invalid video mode");
        halt();
    }
    inj_println("Selecting the video mode info...");
    result = vbe_select_mode_info(); // Получение информации об оптимальном видеорежиме.
    if (result.al != VBE_FUNC_RESULT_AL_SUPPORTED) {
        inj_println("Selecting the video mode info isn't supported");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_FAILED) {
        inj_println("Failed to select the video mode info");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_INVALID_HARDWARE) {
        inj_println("Invalid hardware configuration");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_INVALID_MODE) {
        inj_println("Invalid video mode");
        halt();
    }
}

void lc_pmode() {
    inj_println("Entering to the protected mode...");
    pmode_enter(); // Переход в защищённый режим.
    __asm__(".code32");
    pmode_clear();
    lc_vbe_init();
}

__asm__(".code32");

void lc_vbe_init() {
    pmode_println("Setting the video mode...");
    pmode_println(util_uint32_to_str(25, 10));
    pmode_println(util_int32_to_str(125, 10));
    pmode_println(util_uint32_to_str(36, 10));
    pmode_println(util_int32_to_str(-125, 10));
    pmode_println(util_uint32_to_str(48, 10));
//    for (int i = 0; i > -50; --i) {
//        pmode_println(util_int32_to_str(i, 10));
//    }
    halt();
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