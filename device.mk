#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

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
