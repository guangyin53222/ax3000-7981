#!/bin/bash
set -euo pipefail

echo "==> diy-part2.sh: post feeds install"

cd "$(dirname "$0")" || exit 1

if [ -d "$GITHUB_WORKSPACE/files" ]; then
  cp -r "$GITHUB_WORKSPACE/files" ./
fi

# hostname
sed -i 's/OpenWrt/OpenWrt-T7/g' ./package/base-files/files/etc/hostname

# 默认 LAN
sed -i 's/192.168.1.1/192.168.100.1/g' ./package/base-files/files/bin/config_generate

echo "==> diy-part2.sh done"
