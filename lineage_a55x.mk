#
# Copyright (C) The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

## Inherit from generic products, most specific first
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from a55x device
$(call inherit-product, device/samsung/a55x/device.mk)

## Boot Animation
TARGET_SCREEN_HEIGHT := 2340
TARGET_SCREEN_WIDTH := 1080

## Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

## Device identifier, this must come after all inclusions
PRODUCT_DEVICE := a55x
PRODUCT_NAME := lineage_a55x
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-A556E
PRODUCT_MANUFACTURER := samsung
PRODUCT_SHIPPING_API_LEVEL := 34

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="a55xnsxx-user 14 UP1A.231005.007 A556EXXS9BYGX release-keys" \
    BuildFingerprint=samsung/a55xnsxx/a55x:14/UP1A.231005.007/A556EXXS9BYGX:user/release-keys \
    DeviceName=a55xnsxx \
    DeviceProduct=a55xnsxx \
    SystemDevice=a55xnsxx \
    SystemName=a55xnsxx

PRODUCT_GMS_CLIENTID_BASE := android-samsung
