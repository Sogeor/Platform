#pragma once

#include <stdint.h>

#include "dap.h"
#include "injector.h"
#include "pmode.h"
#include "utils.h"
#include "vbe.h"

void lifecycle();

void lc_vbe_load();

void lc_pmode();

void lc_vbe_init();