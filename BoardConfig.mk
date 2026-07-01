#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/samsung/a55x

# Inherit proprietary vendor configuartion
include vendor/samsung/a55x/BoardConfigVendor.mk

## A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS := \
    boot \
    vendor_boot \
    vbmeta_vendor \
    dtbo \
    odm \
    product \
    vbmeta \
    system \
    vbmeta_system \
    vendor \
    vendor_dlkm

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a76

# Dynamic Partitions
BOARD_SUPER_PARTITION_SIZE := 8321499136
BOARD_SUPER_PARTITION_GROUPS := samsung_dynamic_partitions
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_SIZE := 8317304832
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_dlkm system_ext vendor vendor_dlkm

# Filesystem
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# Platform
BOARD_VENDOR := samsung
TARGET_BOARD_PLATFORM := erd8845
TARGET_BOOTLOADER_BOARD_NAME := s5e8845
TARGET_SOC := s5e8845

# Vendor boot
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
