#include "build.h"

#if BUILD_TYPE == BUILD_TYPE_DEBUG
#define DEBUG

// #pragma region DEBUG_VBE

#define DEBUG_VBE_MIN_WIDTH 800
#define DEBUG_VBE_MIN_HEIGHT 600

#define DEBUG_VBE_MAX_WIDTH 1280
#define DEBUG_VBE_MAX_HEIGHT 1024

// #pragma endregion DEBUG_VBE

#endif // BUILD_TYPE == BUILD_TYPE_DEBUG