#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# Copyright (C) The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

import os
import sys
import tempfile
from zipfile import ZipFile
from shutil import copytree

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
    'vendor/bin/hw/gps.sh': blob_fixup()
        .regex_replace('apex/com.samsung.android.gnss.lsi.rose', 'vendor')
        .regex_replace('bin/gpsd_K44', 'bin/hw/gpsd_K44')
        .regex_replace('etc/firmware', 'firmware/gnss')
        .regex_replace('etc/cfg', 'etc/gnss')
        .regex_replace('gps.rose', 'gps')
        .regex_replace('gps.rose.dcm', 'gps.dcm')
        .regex_replace('gps.rose.kdi', 'gps.kdi'),
    (
        'vendor/etc/init/init.gps.rose.rc',
        'vendor/etc/init/vendor.samsung.hardware.gnss-service.rc'
    ): blob_fixup()
        .regex_replace('apex/com.samsung.android.gnss.lsi.rose', 'vendor')
        .regex_replace('/bin/(?!hw/)', '/bin/hw/')
        .regex_replace('gps.rose.dcm.cfg', 'gps.dcm.cfg')
        .regex_replace('gps.rose.sh', 'gps.sh')
        .regex_replace('.lsi.rose', ''),
    'vendor/lib64/hw/camera.s5e8845.so': blob_fixup()
        .sig_replace('e7 89 01 94', '1f 20 03 d5')  # NOP VendorCameraIPCtoRIL::enable m_sendRequest()
        .sig_replace('92 89 01 94', '1f 20 03 d5') # NOP VendorCameraIPCtoRIL::disable m_sendRequest()
        .sig_replace('48 d1 ff 10 1f 20 03 d5 09 dc ff 10', 'c8 e7 ff 10 1f 20 03 d5 09 dc ff 10')
        # Enable RAW Support
        .sig_replace('28 00 80 52 29 1c 00 72', '13 00 00 14 29 1c 00 72')
        .sig_replace(
            'ff 83 01 d1 fd 7b 02 a9 f8 5f 03 a9 f6 57 04 a9 f4 4f 05 a9 fd 83 00 91 57 d0 3b d5 f3 03 00 aa f4 03 08 aa',
            '1f 7d 00 a9 1f 09 00 f9 c0 03 5f d6 61 00 80 52 42 00 7d b2 28 00 80 52 eb ff ff 17 f3 03 00 aa f4 03 08 aa')
        .add_needed('libui_shim.so'),
    'vendor/lib64/libskeymint_cli.so': blob_fixup()
        .replace_needed('libcrypto.so', 'libcrypto-v33.so'),
    'vendor/lib64/libsec-ril-impl.so': blob_fixup()
        # Always emit uiccApplicationsEnablementChanged
        .sig_replace('1f 00 08 6b ab 01 00 54', '1f 00 08 6b 1f 20 03 d5')
        .sig_replace('bf 02 08 6b ab 01 00 54', 'bf 02 08 6b 1f 20 03 d5')
        # Skip legacy UICC code
        .sig_replace('1f 00 08 6b 0c 01 00 54', '1f 00 08 6b 08 00 00 14'),
    'vendor/lib64/libsensorlistener.so': blob_fixup()
        .add_needed('libshim_sensorndkbridge.so'),
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

if len(sys.argv) > 1 and os.path.isdir(sys.argv[1]):
    apex_path = os.path.join(sys.argv[1], 'vendor/apex/com.samsung.android.gnss.lsi.rose.signed')

    if not os.path.isdir(apex_path):
        print(f'Extracting {apex_path}...')
        with tempfile.TemporaryDirectory() as tmp_dir:
            ZipFile(apex_path + '.apex').extractall(tmp_dir)
            with tempfile.TemporaryDirectory() as tmp_payload_dir:
                os.system('sudo mount -o ro ' + tmp_dir + '/apex_payload.img ' + tmp_payload_dir)
                copytree(tmp_payload_dir, apex_path, ignore = lambda path, names: 'lost+found')
                os.system('sudo umount ' + tmp_payload_dir)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
