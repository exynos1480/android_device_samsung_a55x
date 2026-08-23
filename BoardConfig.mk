#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/samsung/a55x

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76

# Platform
BOARD_VENDOR := samsung
TARGET_BOARD_PLATFORM := s5e8845
TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_BOARD_PLATFORM)
TARGET_SOC := $(TARGET_BOARD_PLATFORM)

# Security
VENDOR_SECURITY_PATCH := 2026-09-05

# VINTF
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += hardware/samsung/vintf/samsung_framework_compatibility_matrix.xml
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/configs/vintf/manifest.xml
