#!/bin/bash
#
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# ========= VNT2 核心源码 + Luci面板插件 =========
rm -rf package/vnt
git clone https://github.com/vnt-dev/vnt package/vnt
rm -rf package/luci-app-vnt2
git clone https://github.com/guangyin53222/luci-app-vnt2 package/luci-app-vnt2

echo "diy-part2.sh done."
