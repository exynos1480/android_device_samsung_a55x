#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_client \
    update_engine_sideload \
    update_verifier

# Kernel Modules
PRODUCT_PACKAGES += \
    toolbox.vendor_ramdisk

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Platform
BOARD_SHIPPING_API_LEVEL := 34
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := $(PRODUCT_BRAND)
PRODUCT_SHIPPING_API_LEVEL := $(BOARD_SHIPPING_API_LEVEL)

# Soong Namespaces
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# Inherit from the proprietary version
$(call inherit-product-if-exists, vendor/samsung/a55x/a55x-vendor.mk)
