/*
 * Copyright (C) The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <libinit_dalvik_heap.h>
#include <libinit_utils.h>
#include <libinit_variant.h>
#include "vendor_init.h"

#include <android-base/properties.h>

using android::base::GetProperty;

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

    std::string model = GetProperty("ro.boot.product.model", "");
    if (model.empty()) {
        model = GetProperty("ro.boot.em.model", "");
    }
    set_ro_build_prop("model", model, true);
    set_ro_build_prop("product", model, false);

    set_dalvik_heap();
}
