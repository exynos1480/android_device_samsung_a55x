/*
 * Copyright (C) The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <android-base/logging.h>
#include <android-base/properties.h>
#include <libinit_utils.h>
#include <libinit_variant.h>

using android::base::GetProperty;

#define EM_MODEL_PROP "ro.boot.em.model"
#define CARRIER_ID_PROP "ro.boot.carrierid"

std::string get_csc_code() {
    std::string carrier_id = GetProperty(CARRIER_ID_PROP, "");

    if (carrier_id.empty()) {
        return "";
    }
    return carrier_id;
}

void search_variant(const std::vector<variant_info_t> variants) {
    std::string em_model_prop = GetProperty(EM_MODEL_PROP, "");
    std::string csc_code_prop = get_csc_code();

    for (const auto& variant : variants) {
        if (variant.model == em_model_prop
            && variant.csc_code == csc_code_prop) {
            set_variant_props(variant);
            return;
        }
    }
}

void set_variant_props(const variant_info_t variant) {
    set_ro_build_prop("device", variant.device, true);
    set_ro_build_prop("model", variant.model, true);
    set_ro_build_prop("name", variant.name, true);
    property_override("ro.boot.csc", variant.csc_code, true);

    if (access("/system/bin/recovery", F_OK) != 0) {
        property_override("ro.bootimage.build.fingerprint", variant.build_fingerprint);
        property_override("ro.build.description", variant.build_desc);
    }
}
