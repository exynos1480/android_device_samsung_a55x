#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/samsung/a55x

# Inherit proprietary vendor configuartion
include vendor/samsung/a55x/BoardConfigVendor.mk

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a76

# Platform
BOARD_VENDOR := samsung
TARGET_BOARD_PLATFORM := erd8845
TARGET_BOOTLOADER_BOARD_NAME := s5e8845
TARGET_SOC := s5e8845
