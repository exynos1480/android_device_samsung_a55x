#!/system/bin/sh
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

if [ "$(getprop init.svc.recovery)" != "running" ]; then
  exit 0
fi

if ! strings /dev/block/sda31 | grep -Eq "BYI1|BYI4"; then
  log -pe -t check_firmware "Unsupported firmware on A slot"
  exit 1
fi

if ! strings /dev/block/sda32 | grep -Eq "BYI1|BYI4"; then
  log -pe -t check_firmware "Unsupported firmware on B slot"
  exit 1
fi

exit 0
