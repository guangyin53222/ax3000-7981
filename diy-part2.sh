#!/bin/bash
#
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Target: immortalwrt-mt798x-rebase @ 25.12
# Device: 360 T7

set -euo pipefail

echo "==> Running diy-part2.sh ..."

# --------------------------
# 默认主题
# --------------------------
DEFAULT_THEME="footstrap"

if [[ "${DEFAULT_THEME}" == "footstrap" ]]; then
  echo "==> Set default theme: footstrap"
  sed -i 's/luci-theme-bootstrap/luci-theme-footstrap/g' feeds/luci/collections/luci/Makefile
else
  echo "==> Set default theme: argon"
  sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
fi

# --------------------------
# 修改主机名 & LAN IP
# --------------------------
sed -i 's/OpenWrt/aRwrt/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# --------------------------
# Vantage：移除对 vantage theme 的硬依赖
# --------------------------
if [ -f package/luci-app-vantage/Makefile ]; then
  echo "==> Patch vantage remove theme dependency"
  sed -i '/luci-theme-vantage/d' package/luci-app-vantage/Makefile
fi

echo "✅ diy-part2.sh finished."
