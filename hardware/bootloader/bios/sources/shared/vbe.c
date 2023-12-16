#include "vbe.h"

__asm__(".code32");

__attribute__((section(".vbe"))) vbe_result_t vbe_result_compute(__vbe_result_t result)
{
    vbe_result_t answer = {
        (uint8_t)(result),
        (uint8_t)(result >> 8)
    };
    return answer;
}

__attribute__((section(".vbe"))) __vbe_result_t vbe_get_controller_info()
{
    __vbe_result_t result;
    __pmode_leave__();
    __asm__(".code16gcc");
    result = __vbe_get_controller_info__();
    __pmode_enter__();
    __asm__(".code32");
    return result;
}

__attribute__((section(".vbe"))) __vbe_result_t vbe_get_mode_info(uint16_t mode_number)
{
    __vbe_result_t result;
    __pmode_leave__();
    __asm__(".code16gcc");
    __asm__("call __vbe_get_mode_info__" : "=a"(result) : "c"(mode_number));
    __pmode_enter__();
    __asm__(".code32");
    return result;
}

__attribute__((section(".vbe"))) __vbe_result_t vbe_set_mode(uint16_t mode_number)
{
    __vbe_result_t result;
    __pmode_leave__();
    __asm__(".code16gcc");
    __asm__("call __vbe_set_mode__" : "=a"(result) : "b"(mode_number));
    __pmode_enter__();
    __asm__(".code32");
    return result;
}

__attribute__((section(".vbe"))) vbe_result_t vbe_select_mode_info()
{
    vbe_result_t result;
    uint16_t *ptr = pmode_ptr_compute(&__vbe_controller_info.list_of_mode_numbers_ptr);
    __vbe_mode_brief.number = VBE_LIST_OF_MODE_NUMBER_TERMINATION;
    for (; *ptr != VBE_LIST_OF_MODE_NUMBER_TERMINATION; ++ptr)
    {
        result = vbe_result_compute(vbe_get_mode_info(*ptr));
        if (!(__vbe_mode_info.attributes & 1))
        {
            continue;
        }
        if (!(__vbe_mode_info.attributes & (1 << 7)))
        {
            continue;
        }
        if (result.al != VBE_FUNC_RESULT_AL_SUPPORTED || result.ah != VBE_FUNC_RESULT_AH_SUCCESSFUL)
        {
            pmode_println_string("[error] [vbe_select_mode_info] failed to get vbe mode info");
            return result;
        }
        #if BUILD_TYPE == BUILD_TYPE_DEBUG
        if (__vbe_mode_info.width > BUILD_DEBUG_VBE_MAX_WIDTH || __vbe_mode_info.height > BUILD_DEBUG_VBE_MAX_HEIGHT)
        {
            continue;
        }
        #endif
        if (__vbe_mode_info.width < __vbe_mode_brief.width || __vbe_mode_info.height <= __vbe_mode_brief.height)
        {
            continue;
        }
        __vbe_mode_brief.number = *ptr;
        __vbe_mode_brief.width = __vbe_mode_info.width;
        __vbe_mode_brief.height = __vbe_mode_info.height;
    }
    if (__vbe_mode_brief.number == VBE_LIST_OF_MODE_NUMBER_TERMINATION)
    {
        result.ah = VBE_FUNC_RESULT_AH_FAILED;
        return result;
    }
    if (__vbe_mode_brief.number != *ptr)
    {
        result = vbe_result_compute(vbe_get_mode_info(__vbe_mode_brief.number));
        if (result.al != VBE_FUNC_RESULT_AL_SUPPORTED || result.ah != VBE_FUNC_RESULT_AH_SUCCESSFUL)
        {
            pmode_println_string("[error] [vbe_select_mode_info] failed to get vbe mode info");
            return result;
        }
    }
    __vbe_mode_brief.buffer_size = __vbe_mode_info.height * __vbe_mode_info.number_of_bytes_in_line / 4096;
    return result;
}

__attribute__((section(".vbe"))) vbe_result_t vbe_select_mode()
{
    return vbe_result_compute(vbe_set_mode(__vbe_mode_brief.number));
}