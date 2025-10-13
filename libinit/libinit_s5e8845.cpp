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

static const variant_info_t a55xnaxx_eux = {
    .device = "a55x",
    .model = "SM-A556B",
    .name = "a55xnaxx",
    .build_fingerprint = "samsung/a55xnaxx/a55x:14/UP1A.231005.007/A556BXXSABYI1:user/release-keys",
    .build_desc = "a55xnaxx-user 14 UP1A.231005.007 A556BXXSABYI1 release-keys"
};

static const variant_info_t a55xnsxx_xme = {
    .device = "a55x",
    .model = "SM-A556E",
    .name = "a55xnsxx",
    .build_fingerprint = "samsung/a55xnsxx/a55x:14/UP1A.231005.007/A556EXXSABYI2:user/release-keys",
    .build_desc = "a55xnsxx-user 14 UP1A.231005.007 A556EXXSABYI2 release-keys"
};

static const std::vector<variant_info_t> variants = {
    a55xnaxx_eux,
    a55xnsxx_xme,
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
