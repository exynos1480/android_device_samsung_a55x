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
    'hardware/samsung',
    'hardware/samsung_slsi-linaro/exynos',
    'hardware/samsung_slsi-linaro/graphics',
    'hardware/samsung_slsi-linaro/sgpu',
    'vendor/samsung/a55x',
]

blob_fixups: blob_fixups_user_type = {
    'vendor/etc/media_codecs_performance_c2.xml': blob_fixup()
        .regex_replace('.*sec\\.(.|\n)*D', '    </D'),
    'vendor/lib64/hw/camera.s5e8845.so': blob_fixup()
        .sig_replace('e7 89 01 94', '1f 20 03 d5')  # NOP VendorCameraIPCtoRIL::enable m_sendRequest()
        .sig_replace('92 89 01 94', '1f 20 03 d5') # NOP VendorCameraIPCtoRIL::disable m_sendRequest()
        .add_needed('libui_shim.so'),
    'vendor/lib64/libskeymint_cli.so': blob_fixup()
        .replace_needed('libcrypto.so', 'libcrypto-v33.so'),
    (
        'vendor/lib64/hw/vulkan.samsung.so',
        'vendor/lib64/libSGPUOpenCL.so',
        'vendor/lib64/egl/libGLESv2_samsung.so',
    ): blob_fixup()
        .clear_symbol_version('AHardwareBuffer_acquire')
        .clear_symbol_version('AHardwareBuffer_allocate')
        .clear_symbol_version('AHardwareBuffer_describe')
        .clear_symbol_version('AHardwareBuffer_getId')
        .clear_symbol_version('AHardwareBuffer_getNativeHandle')
        .clear_symbol_version('AHardwareBuffer_release')
        .clear_symbol_version('ANativeWindow_getFormat'),
}  # fmt: skip

def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    'libuuid': lib_fixup_vendor_suffix,
}

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
