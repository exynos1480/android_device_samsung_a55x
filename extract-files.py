#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# Copyright (C) The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/samsung/a55x',
    'vendor/samsung/a55x',
]

blob_fixups: blob_fixups_user_type = {
    'vendor/etc/init/init.nfc.samsung.rc': blob_fixup()
        .regex_replace('system', 'secure_element'),
    'vendor/lib64/libsec-ril.so': blob_fixup()
        .replace_needed('libprotobuf-cpp-full-21.7.so', 'libprotobuf-cpp-full-21.12.so')
        .sig_replace(
            '80 0e 40 f9 e1 03 16 aa 82 0c 80 52 e3 03 15 aa 24 00 80 52',
            '80 0e 40 f9 e1 03 16 aa 82 0c 80 52 03 00 80 d2 24 00 80 52'),
    (
        'vendor/lib64/hw/audio.primary.s5e8845.so',
        'vendor/lib64/libaudioproxy2.so',
        'vendor/lib64/libaudioparamupdate.so',
    ): blob_fixup()
        .replace_needed('libaudioroute.so', 'libaudioroute_samsung.so')
        .replace_needed('libtinyalsa.so', 'libtinyalsa_samsung.so'),
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
    'vendor/lib64/libexynosgraphicbuffer.so': blob_fixup()
        .add_needed('libshim_ui.so'),
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
}  # fmt: skip

module = ExtractUtilsModule(
    'r0s',
    'samsung',
    namespace_imports=namespace_imports,
    blob_fixups=blob_fixups,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(
        module, 'a55x', module.vendor
    )
    utils.run()
