/*
 * Copyright (C) The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <libinit_variant.h>

#include "vendor_init.h"

static const variant_info_t unknown = {
    .device = "unknown",
    .model = "unknown",
    .name = "unknown",
    .build_fingerprint = "unknown",
    .build_desc = "unknown"
};

static const std::vector<variant_info_t> variants = {
    unknown,
};

void vendor_load_properties() {
    search_variant(variants);
}
