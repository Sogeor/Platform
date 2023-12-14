#include "lifecycle.h"

__asm__(".code16gcc");

void lifecycle() {
    // Подготовка к переходу в защищённый режим.
    inj_println("Entering to the protected mode...");
    // Переход в защищённый режим.
    pmode_enter();
    __asm__(".code32");
    // Подготовка к работе в защищённом режиме.
    pmode_clear();
    pmode_println("Getting the VBE controller info...");
    vbe_func_result_t result = vbe_get_controller_info(); // Получение информации о контроллере VBE.
    pmode_print(util_uint32_to_str(result.ah, 2));
    pmode_println(util_uint32_to_str(result.al, 2));
//    result = vbe_get_controller_info(); // Получение информации о контроллере VBE.
//    pmode_print(util_uint32_to_str(result.ah, 2));
//    pmode_println(util_uint32_to_str(result.al, 2));
    if (result.al != VBE_FUNC_RESULT_AL_SUPPORTED) {
        pmode_println("Getting the VBE controller info isn't supported");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_FAILED) {
        pmode_println("Failed to get the VBE controller info");
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
    pmode_println("Selecting the video mode info...");
    result = vbe_select_mode_info(); // Получение информации об оптимальном видеорежиме.
    pmode_print(util_uint32_to_str(result.ah, 2));
    pmode_println(util_uint32_to_str(result.al, 2));
    if (result.al != VBE_FUNC_RESULT_AL_SUPPORTED) {
        pmode_println("Selecting the video mode info isn't supported");
        halt();
    }
    if (result.ah == VBE_FUNC_RESULT_AH_FAILED) {
        pmode_println("Failed to select the video mode info");
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
    pmode_println("Setting the video mode...");
    //    for (int i = 0; i > -50; --i) {
    //        pmode_println(util_int32_to_str(i, 10));
    //    }
    halt();
    result = vbe_select_mode(vbe_mode_summary.number); // Установка видеорежима.
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