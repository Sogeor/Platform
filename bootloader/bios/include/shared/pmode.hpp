#pragma once

#include <stdint.h>

#define PMODE_VIDEO_MEMORY_ADDRESS 0xB8000

/**
 * @brief Содержит инструменты для работы в защищённом режиме.
 * */
namespace pmode {
    /**
     * @brief Содержит данные о курсоре.
     * */
    typedef struct cursor_s {
        uint32_t x;
        uint32_t y;
    } __attribute__((packed)) cursor_t;

    /**
     * @brief Содержит данные о курсоре.
     * */
    extern static cursor_t cursor;

    /**
     * @brief Печатает символ на экран.
     * */
    void print(const char c);

    /**
     * @brief Печатает строку на экран.
     * */
    void print(const char *s);

    /**
     * @brief Перемещает курсор на следующую строку.
     * */
    void println();

    /**
     * @brief Печатает символ на экран и перемещает курсор на следующую строку.
     * */
    void println(const char c);

    /**
     * @brief Печатает строку на экран и перемещает курсор на следующую строку.
     * */
    void println(const char *s);

    /**
     * @brief Форматирует строку и печатает её на экран.
     * */
    void printf(const char *s, const char *d);
}