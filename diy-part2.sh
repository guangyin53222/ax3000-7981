#!/bin/bash
#
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Target: immortalwrt-mt798x-rebase @ 25.12
#

set -euo pipefail

echo "==> Running diy-part2.sh ..."

# --------------------------
# 设置默认主题
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
# 预置一些常用配置（可选）
# --------------------------
# 修改主机名
sed -i 's/OpenWrt/360T7/g' package/base-files/files/bin/config_generate

# 修改默认 LAN IP（按需）
sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# --------------------------
# 清理 / 补丁（按需）
# --------------------------
# 如果后续需要给插件打补丁、修改 Makefile，放这里
# example:
# sed -i ...

echo "✅ diy-part2.sh finished."
