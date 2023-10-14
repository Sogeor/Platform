#include "vbe.h"

__asm__(".code16gcc");

vbe_func_result_t vbe_get_controller_info() {
    vbe_func_result_t result;
    __asm__("call vbe_update_controller_info" : "=a"(result));
    return result;
}

vbe_func_result_t vbe_get_mode_info(uint16_t mode_number) {
    vbe_func_result_t result;
    __asm__("call vbe_update_mode_info" : "=a"(result) : "c"(mode_number));
    return result;
}

vbe_func_result_t vbe_select_mode_info() {
    vbe_func_result_t result;
    uint32_t *list_of_mode_numbers_ptr = util_parse_r_ptr(&vbe_controller_info.list_of_mode_numbers_ptr);
    vbe_mode_summary.number = VBE_MODE_NUMBER_LIST_TERMINATION;
    vbe_mode_summary.width = 0;
    vbe_mode_summary.height = 0;
    for (; *list_of_mode_numbers_ptr != VBE_MODE_NUMBER_LIST_TERMINATION; list_of_mode_numbers_ptr++) {
        result = vbe_get_mode_info(*list_of_mode_numbers_ptr);
        if (result.ah != VBE_FUNC_RESULT_AH_SUCCESSFUL) return result;
        if (!(vbe_mode_info.attributes & (1 << 7)))
            continue; // Пропуск режима, если он не поддерживает линейный буфер.
        if (vbe_mode_info.width > vbe_mode_summary.width || (vbe_mode_info.width == vbe_mode_summary.width &&
                                                             vbe_mode_info.height >
                                                             vbe_mode_summary.height)) { // Сохранение текущего режима как лучшего.
            vbe_mode_summary.number = *list_of_mode_numbers_ptr;
            vbe_mode_summary.width = vbe_mode_info.width;
            vbe_mode_summary.height = vbe_mode_info.height;
        }
    }
    if (vbe_mode_summary.number == VBE_MODE_NUMBER_LIST_TERMINATION) {
        result.ah = VBE_FUNC_RESULT_AH_FAILED;
        return result;
    }
    return *list_of_mode_numbers_ptr != vbe_mode_summary.number ? vbe_get_mode_info(vbe_mode_summary.number) : result;
}

vbe_func_result_t vbe_select_mode(uint16_t mode_number) {
    vbe_func_result_t result;
    __asm__("call vbe_update_mode" : "=a"(result) : "b"(mode_number));
    return result;
}