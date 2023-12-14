#include "pmode.hpp"

__asm__(".code32");

namespace pmode {
    void print(const char c) {
        static int x = 0, y = 0;
        if (c == '\n') {
            cursor.y++;
            return;
        }
        if (c == '\r') {
            cursor.x = 0;
            return;
        }
        *((uint16_t *) 0xB8000 + y * 80 + x) = 0x0F00 | c;
        ++x;
    }

    void print(const char *s) {

    }

    void println() {

    }

    void println(const char c) {

    }

    void println(const char *s) {

    }

    void printf(const char *s, const char *d) {

    }
}