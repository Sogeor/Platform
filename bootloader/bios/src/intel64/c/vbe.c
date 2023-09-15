#include "vbe.h"

__asm__(".code16gcc");

void select_optimal_vbe_mode_info() {
    vbe_mode_info_t* backup_mode = (vbe_mode_info_t*) (uint64_t) vbe_controller_info.video_modes_ptr;
    print_adapter("current mode: ");
    println_adapter(util_uint32_to_str(backup_mode, 10));
//    if (!backup_mode || backup_mode[0] == 0xFFFF) halt(); // TODO: more info
    vbe_mode_info_t* current_mode;
    size_t index;
    for (index = 1; (current_mode = (vbe_mode_info_t*) (uint64_t) (vbe_controller_info.video_modes_ptr + index * sizeof(vbe_mode_info_t))); index++) { // TODO: wtf...
        print_adapter("current mode: ");
        println_adapter(util_uint32_to_str(current_mode->width, 10));
        if (current_mode->width > backup_mode->width) {
            backup_mode = current_mode;
            continue;
        }
        if (current_mode->width == backup_mode->width && current_mode->height > backup_mode->height) {
            backup_mode = current_mode;
            continue;
        }
        // TODO: more conditions
    }
    vbe_current_mode_info = backup_mode;
}

vbe_mode_info_t *vbe_current_mode_info;