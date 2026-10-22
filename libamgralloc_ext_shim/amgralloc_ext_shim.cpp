/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#include <cstdint>

#include <cutils/native_handle.h>

void am_gralloc_dumpsys_callback(void) {}

uint32_t am_gralloc_get_vpu_afrc_mask(const native_handle_t*) {
    return 0;
}
