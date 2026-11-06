#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# All components inherited here go to system image
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_system.mk)

# All components inherited here go to system_ext image
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_system_ext.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_system_ext.mk)

# All components inherited here go to product image
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)

# All components inherited here go to vendor image
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/media_vendor.mk)
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Enable virtual A/B with vendor ramdisk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Inherit common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system_ext=true \
    POSTINSTALL_PATH_system_ext=bin/check_firmware \
    FILESYSTEM_TYPE_system_ext=ext4 \
    POSTINSTALL_OPTIONAL_system_ext=false

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    check_firmware \
    checkpoint_gc \
    otapreopt_script \
    update_engine \
    update_engine_client \
    update_engine_sideload \
    update_verifier

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.audio.service \
    android.hardware.audio@7.1-impl \
    android.hardware.bluetooth.audio-impl \
    aosp_audio_policy_volumes.xml \
    aosp_default_volume_tables.xml \
    aosp_r_submix_audio_policy_configuration.xml \
    audio_effects.xml \
    audio_policy_configuration.xml \
    audio.bluetooth.default \
    audio.primary.s5e8845 \
    audio.r_submix.default \
    audio.usbv2.default \
    bluetooth_with_le_audio_policy_configuration_7_0.xml \
    mixer_paths.xml \
    usbv2_audio_policy_configuration.xml

$(call soong_config_set_bool,frameworks_av,use_aosp_audio_policy_volumes,true)
$(call soong_config_set_bool,frameworks_av,use_aosp_default_volume_tables,true)
$(call soong_config_set_bool,frameworks_av,use_aosp_r_submix_audio_policy_configuration,true)
$(call soong_config_set_bool,exynos_audio,support_direct_multi_channel_stream,true)
$(call soong_config_set_bool,exynos_audio,use_offload_effect_library,true)
$(call soong_config_set_bool,exynos_audio,use_sec_audio_dynamic_nrec,true)
$(call soong_config_set_bool,exynos_audio,use_sec_audio_samsungrecord,true)
$(call soong_config_set_bool,exynos_audio,use_sec_audio_support_gamechat_spk_aec,true)
$(call soong_config_set_bool,exynos_audio,use_sec_audio_support_listenback_dspeffect,true)
$(call soong_config_set_bool,exynos_audio,use_usb_offload,true)
$(call soong_config_set,exynos_audio,proxy_header,//$(LOCAL_PATH):audio_proxy_headers)
$(call soong_config_set,exynos_audio,sec_resampler_library,//vendor/samsung/a55x:libSamsungPostProcessConvertor)

# Audio - Effects
PRODUCT_PACKAGES += \
    libsamsungSoundbooster_plus \
    SamsungDAP \
    SoundBoosterStage

$(call soong_config_set,samsungAudioVars,soundbooster_dsp_library,//vendor/samsung/a55x:lib_SoundBooster_ver2000)

TARGET_EXCLUDES_AUDIOFX := true

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.1-service \
    libbt-vendor

# Bluetooth - Configuration
PRODUCT_PACKAGES += \
    bt_did.slsi.conf

# Boot Control
PRODUCT_PACKAGES += \
    android.hardware.boot-service.exynos \
    android.hardware.boot-service.exynos_recovery

# Codec2
PRODUCT_PACKAGES += \
    samsung.hardware.media.c2-service \
    libExynosC2H264Dec \
    libExynosC2H264Enc \
    libExynosC2HevcDec \
    libExynosC2HevcEnc \
    libExynosC2Vp8Dec \
    libExynosC2Vp8Enc \
    libExynosC2Vp9Dec \
    libExynosC2Vp9Enc

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider-service.samsung

$(call soong_config_set_bool,samsungCameraVars,needs_fps_field,true)
$(call soong_config_set_bool,samsungCameraVars,usage_64bit,true)

# Display - Configuration
PRODUCT_PACKAGES += \
    displayconfig.xml

# Doze
PRODUCT_PACKAGES += \
    SamsungDoze

# DRM
PRODUCT_PACKAGES += \
    com.android.hardware.drm.clearkey

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint-service.samsung

$(call soong_config_set,samsungUdfpsVars,dim_layer_zorder,0xff)
$(call soong_config_set,samsungUdfpsVars,udfps_zorder,0x100)
$(call soong_config_set,surfaceflinger,udfps_lib,//hardware/samsung/fingerprint:libudfps_extension.samsung)

# Firmware - Placeholders
PRODUCT_PACKAGES += \
    AIE.bin_placeholder \
    calliope_sram.bin_placeholder \
    mfc_fw.bin_placeholder \
    pablo_icpufw.bin_placeholder \
    os.checked.bin_placeholder \
    vts.bin_placeholder

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper-service.teegris

# Graphics
PRODUCT_PACKAGES += \
    android.hardware.composer.hwc3-service.slsi \
    android.hardware.graphics.allocator-aidl-service-sgr \
    android.hardware.graphics.mapper@4.0-impl-sgr \
    android.hardware.memtrack-service.exynos \
    libdrm_sgpu

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.samsung \
    android.hardware.health-service.samsung-recovery \
    vendor.lineage.health-service.default

$(call soong_config_set_bool,lineage_health,charging_control_charging_bypass,true)
$(call soong_config_set_bool,lineage_health,charging_control_charging_deadline,false)
$(call soong_config_set_bool,lineage_health,charging_control_charging_toggle,true)
$(call soong_config_set,lineage_health,charging_control_charging_disabled,0)
$(call soong_config_set,lineage_health,charging_control_charging_enabled,1)
$(call soong_config_set,lineage_health,charging_control_charging_path,/sys/class/power_supply/battery/charging_enabled)
$(call soong_config_set,lineage_health,fast_charge_node,/sys/class/sec/switch/afc_disable)
$(call soong_config_set,lineage_health,fast_charge_value_fast_charge,0)
$(call soong_config_set,lineage_health,fast_charge_value_none,1)

# IMS
$(call inherit-product, hardware/lineage/generic-ims/ims.mk)

# Init
PRODUCT_PACKAGES += \
    fstab.s5e8845 \
    init.a55x.unify.rc \
    init.recovery.s5e8845.rc \
    init.s5e8845.rc \
    init.samsung.rc \
    ueventd.s5e8845.rc

$(call soong_config_set,libinit,vendor_init_lib,//$(LOCAL_PATH):libinit_a55x)

# Kernel
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Kernel Modules
PRODUCT_PACKAGES += \
    toolbox.vendor_ramdisk

# KeyMint
PRODUCT_PACKAGES += \
    android.hardware.security.keymint-service.samsung

# Linker
PRODUCT_PACKAGES += \
    public.libraries.txt

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc-service.sec \
    android.hardware.secure_element-service.thales-st33

# Overlays
PRODUCT_PACKAGES += \
    ApertureOverlay \
    FrameworkResOverlay \
    LineageSDKOverlay \
    NcmTetheringOverlay \
    SettingsOverlay \
    SettingsProviderOverlay \
    SystemUIOverlay \
    WiFiOverlay

PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Permissions
PRODUCT_PACKAGES += \
    android.hardware.audio.low_latency.prebuilt.xml \
    android.hardware.bluetooth_le.prebuilt.xml \
    android.hardware.camera.flash-autofocus.prebuilt.xml \
    android.hardware.camera.full.prebuilt.xml \
    android.hardware.camera.raw.prebuilt.xml \
    android.hardware.fingerprint.prebuilt.xml \
    android.hardware.location.gps.prebuilt.xml \
    android.hardware.nfc.ese.prebuilt.xml \
    android.hardware.nfc.hce.prebuilt.xml \
    android.hardware.nfc.hcef.prebuilt.xml \
    android.hardware.nfc.prebuilt.xml \
    android.hardware.sensor.accelerometer.prebuilt.xml \
    android.hardware.sensor.gyroscope.prebuilt.xml \
    android.hardware.sensor.hifi_sensors.prebuilt.xml \
    android.hardware.sensor.light.prebuilt.xml \
    android.hardware.sensor.proximity.prebuilt.xml \
    android.hardware.sensor.stepcounter.prebuilt.xml \
    android.hardware.sensor.stepdetector.prebuilt.xml \
    android.hardware.telephony.gsm.prebuilt.xml \
    android.hardware.telephony.satellite.prebuilt.xml \
    android.hardware.usb.accessory.prebuilt.xml \
    android.hardware.usb.host.prebuilt.xml \
    android.hardware.vulkan.compute-0.prebuilt.xml \
    android.hardware.vulkan.level-1.prebuilt.xml \
    android.hardware.vulkan.version-1_3.prebuilt.xml \
    android.hardware.wifi.direct.prebuilt.xml \
    android.hardware.wifi.passpoint.prebuilt.xml \
    android.hardware.wifi.prebuilt.xml \
    android.software.ipsec_tunnels.prebuilt.xml \
    android.software.opengles.deqp.level-2023-03-01.prebuilt.xml \
    android.software.vulkan.deqp.level-2023-03-01.prebuilt.xml \
    handheld_core_hardware.prebuilt.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.uicc.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.wifi.aware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.aware.xml \
    frameworks/native/data/etc/android.hardware.wifi.rtt.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.rtt.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# Platform
BOARD_SHIPPING_API_LEVEL := 34
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := $(PRODUCT_BRAND)
PRODUCT_SHIPPING_API_LEVEL := $(BOARD_SHIPPING_API_LEVEL)

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.pixel-libperfmgr

# Power - Configuration
PRODUCT_PACKAGES += \
    powerhint.json

# RIL
PRODUCT_PACKAGES += \
    cbd \
    libsec-ril \
    secril_config_svc \
    sehradiomanager

# RIL - Configuration
PRODUCT_PACKAGES += \
    sehradiomanager.conf

$(call soong_config_set,cbd,protocol,sipc)

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.samsung-multihal \
    sensors.samsung

# Sensors - Configuration
PRODUCT_PACKAGES += \
    hals.conf

# Soong Namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/google/interfaces \
    hardware/google/pixel/pixelstats \
    hardware/google/pixel/power-libperfmgr \
    hardware/google/pixel/thermal \
    hardware/samsung \
    hardware/samsung_slsi/libbt \
    hardware/samsung_slsi/scsc_wifibt/wpa_supplicant_lib \
    hardware/samsung_slsi-linaro/exynos/cpboot_v3 \
    hardware/samsung_slsi-linaro/exynos/libaudio/audiohal_comv1 \
    hardware/samsung_slsi-linaro/exynos/libaudio/audiohal_comv1/proxy

# Task Profiles
PRODUCT_PACKAGES += task_profiles.json.s5e8845

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal-service.pixel \
    thermal_symlinks

# Thermal - Configuration
PRODUCT_PACKAGES += \
    thermal_info_config.json

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.samsung \
    android.hardware.usb.gadget-service.samsung \
    init.s5e8845.usb.rc

$(call soong_config_set,samsungUsbGadgetVars,gadget_name,13200000.dwc3)

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator-service.samsung

# Wi-Fi
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

# Inherit from the proprietary version
$(call inherit-product-if-exists, vendor/samsung/a55x/a55x-vendor.mk)

# Call Samsung LSI board support package makefiles
$(call inherit-product, hardware/samsung_slsi-linaro/config/config.mk)
