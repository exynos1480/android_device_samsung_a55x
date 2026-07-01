#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/samsung/a55x',
    'hardware/samsung_slsi-linaro/exynos',
    'hardware/samsung_slsi-linaro/graphics',
]

def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None

lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    'libuuid': lib_fixup_vendor_suffix,
} # fmt: skip

blob_fixups: blob_fixups_user_type = {
    'vendor/bin/hw/android.hardware.graphics.composer3-service.exynos': blob_fixup()
        .replace_needed(
            'android.hardware.graphics.composer@2.1-resources.so',
            'android.hardware.graphics.composer@2.1-resources_samsung.so')
        .replace_needed(
            'android.hardware.graphics.composer@2.2-resources.so',
            'android.hardware.graphics.composer@2.2-resources_samsung.so'),
    'vendor/etc/init/android.hardware.security.keymint-service.samsung.rc': blob_fixup()
        .regex_replace(
            'android\\.hardware\\.security\\.keymint-service\n',
            'android.hardware.security.keymint-service.samsung\n'),
    'vendor/lib64/android.hardware.graphics.composer@2.2-resources_samsung.so': blob_fixup()
        .replace_needed(
            'android.hardware.graphics.composer@2.1-resources.so',
            'android.hardware.graphics.composer@2.1-resources_samsung.so'),
    'vendor/lib64/hw/vulkan.samsung.so': blob_fixup()
        .clear_symbol_version('AHardwareBuffer_acquire')
        .clear_symbol_version('AHardwareBuffer_allocate')
        .clear_symbol_version('AHardwareBuffer_describe')
        .clear_symbol_version('AHardwareBuffer_getId')
        .clear_symbol_version('AHardwareBuffer_getNativeHandle')
        .clear_symbol_version('AHardwareBuffer_release'),
    'vendor/lib64/libSGPUOpenCL.so': blob_fixup()
        .clear_symbol_version('AHardwareBuffer_acquire')
        .clear_symbol_version('AHardwareBuffer_describe')
        .clear_symbol_version('AHardwareBuffer_getNativeHandle')
        .clear_symbol_version('AHardwareBuffer_release'),
    'vendor/lib64/egl/libGLESv2_samsung.so': blob_fixup()
        .clear_symbol_version('AHardwareBuffer_allocate')
        .clear_symbol_version('ANativeWindow_getFormat'),
    (
        'vendor/lib64/hw/audio.primary.s5e8845.so',
        'vendor/lib64/libaudioproxy2.so',
        'vendor/lib64/libaudioparamupdate.so',
    ): blob_fixup()
        .replace_needed('libaudioroute.so', 'libaudioroute_samsung.so')
        .replace_needed('libtinyalsa.so', 'libtinyalsa_samsung.so'),
    'vendor/etc/init/vendor.samsung.hardware.camera.provider-service_64.rc': blob_fixup()
        .regex_replace('vendor_secdir w', 'w')
        .regex_replace('vendor_secdir', 'camera'),
    'vendor/lib64/lib_profiler.so': blob_fixup()
        .replace_needed('libprotobuf-cpp-full-21.7.so', 'libprotobuf-cpp-full-21.12.so'),
    (
        'vendor/lib64/libsensorlistener.so',
        'vendor/lib64/libvdis_core.so',
    ): blob_fixup()
        .add_needed('libshim_sensorndkbridge.so'),
    (
        'vendor/lib64/libalsautils_sec.so',
        'vendor/lib64/libaudioroute_samsung.so',
    ): blob_fixup()
        .replace_needed('libtinyalsa.so', 'libtinyalsa_samsung.so'),
    (
        'vendor/lib/sensors.grip.so',
        'vendor/lib/sensors.inputvirtual.so',
        'vendor/lib/sensors.sensorhub.so',
        'vendor/lib64/sensors.grip.so',
        'vendor/lib64/sensors.inputvirtual.so',
        'vendor/lib64/sensors.sensorhub.so',
    ): blob_fixup()
        .remove_needed('libhidltransport.so')
        .add_needed('libutils-v32.so')
        .binary_regex_replace(b'_ZN7android6Thread3runEPKcim', b'_ZN7utils326Thread3runEPKcim'),
    'vendor/lib64/libexynosgraphicbuffer.so': blob_fixup()
        .add_needed('libshim_ui.so'),
    'vendor/etc/init/init.nfc.samsung.rc': blob_fixup()
        .regex_replace('system', 'secure_element'),
    'vendor/lib64/libsec-ril.so': blob_fixup()
        .replace_needed('libprotobuf-cpp-full-21.7.so', 'libprotobuf-cpp-full-21.12.so')
        .sig_replace(
            '80 0e 40 f9 e1 03 16 aa 82 0c 80 52 e3 03 15 aa 24 00 80 52',
            '80 0e 40 f9 e1 03 16 aa 82 0c 80 52 03 00 80 d2 24 00 80 52'),
    'vendor/lib64/libskeymint_cli.so': blob_fixup()
        .add_needed('libshim_crypto.so'),
    'vendor/bin/hermesd': blob_fixup()
        .binary_regex_replace(b'security.securehw.available', b'vendor.securehw.available\x00\x00')
        .binary_regex_replace(b'security.securenvm.available', b'vendor.securenvm.available\x00\x00'),
}  # fmt: skip

module = ExtractUtilsModule(
    'a55x',
    'samsung',
    namespace_imports=namespace_imports,
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
