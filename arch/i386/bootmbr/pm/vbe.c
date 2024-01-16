#include "vbe.h"

__asm__(".code32");

__attribute__((unused, section(".vbe")))
void __vbe_result_parse(vbe_result_t result, vbe_result_table_t *result_table)
{
    result_table->al = result;
    result_table->ah = result >> 8;
}

__attribute__((unused, section(".vbe")))
vbe_result_t __vbe_result_compute(vbe_result_table_t *result_table)
{
    return result_table->al + (((vbe_result_t) result_table->ah) << 8);
}

__attribute__((section(".vbe")))
vbe_result_t __vbe_query_controller_info()
{
    vbe_result_t result;
    __pm_leave();
    __asm__(".code16gcc");
    __asm__("call __vbe_get_controller_info" : "=a"(result));
    __pm_enter();
    __asm__(".code32");
    return result;
}

__attribute__((section(".vbe")))
vbe_result_t __vbe_require_mode(vbe_mode_number_t mode_number)
{
    vbe_result_t result;
    __pm_leave();
    __asm__(".code16gcc");
    __asm__("call __vbe_set_mode" : "=a"(result) : "b"(mode_number));
    __pm_enter();
    __asm__(".code32");
    return result;
}

__attribute__((section(".vbe")))
vbe_result_t __vbe_query_mode_info(vbe_mode_number_t mode_number)
{
    vbe_result_t result;
    __pm_leave();
    __asm__(".code16gcc");
    __asm__("call __vbe_get_mode_info" : "=a"(result) : "c"(mode_number));
    __pm_enter();
    __asm__(".code32");
    return result;
}

__attribute__((section(".vbe")))
vbe_result_t __vbe_select_mode_info()
{
    vbe_result_t result;
    vbe_result_table_t result_table;
    vbe_mode_number_t *ptr = (vbe_mode_number_t*) __ptr_compute(&__vbe_controller_info.mode_numbers_ptr);
    __vbe_mode_brief.number = VBE_CONTROLLER_INFO_MODE_NUMBERS_END;
    for (; *ptr != VBE_CONTROLLER_INFO_MODE_NUMBERS_END; ++ptr)
    {
        result = __vbe_query_mode_info(*ptr);
        __vbe_result_parse(result, &result_table);
        if (!(__vbe_mode_info.attributes & 1))
        {
            continue;
        }
        if (!(__vbe_mode_info.attributes & (1 << 7)))
        {
            continue;
        }
        if (result_table.al != VBE_RESULT_AL_SUPPORTED || result_table.ah != VBE_RESULT_AH_DONE)
        {
            __pm_println("[error] [__vbe_select_mode] failed to get vbe mode info");
            return result;
        }
        #ifdef DEBUG
        if (__vbe_mode_info.width < DEBUG_VBE_MIN_WIDTH || __vbe_mode_info.height <= DEBUG_VBE_MIN_HEIGHT)
        {
            continue;
        }
        if (__vbe_mode_info.width > DEBUG_VBE_MAX_WIDTH || __vbe_mode_info.height >= DEBUG_VBE_MAX_HEIGHT)
        {
            continue;
        }
        #endif // DEBUG
        if (__vbe_mode_info.width < __vbe_mode_brief.width || __vbe_mode_info.height <= __vbe_mode_brief.height)
        {
            continue;
        }
        __vbe_mode_brief.number = *ptr;
        __vbe_mode_brief.width = __vbe_mode_info.width;
        __vbe_mode_brief.height = __vbe_mode_info.height;
    }
    if (__vbe_mode_brief.number == VBE_CONTROLLER_INFO_MODE_NUMBERS_END)
    {
        result_table.ah = VBE_RESULT_AH_FAIL;
        return __vbe_result_compute(&result_table);
    }
    if (__vbe_mode_brief.number != *ptr)
    {
        result = __vbe_query_mode_info(__vbe_mode_brief.number);
        __vbe_result_parse(result, &result_table);
        if (result_table.al != VBE_RESULT_AL_SUPPORTED || result_table.ah != VBE_RESULT_AH_DONE)
        {
            __pm_println("[error] [__vbe_select_mode_info] failed to get vbe mode info");
            return result;
        }
    }
//    __vbe_mode_brief.buffer_size = (u32_t) __vbe_mode_info.height * __vbe_mode_info.number_of_bytes_in_line / 4096;
    __vbe_mode_brief.buffer_size = (u32_t) __vbe_controller_info.number_of_memory_blocks * 64 * 1024;
    return result;
}