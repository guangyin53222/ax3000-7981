#!/bin/bash
set -euo pipefail

echo "==> diy-part2.sh: pull extra packages"

cd "$(dirname "$0")" || exit 1

if [ -d "$GITHUB_WORKSPACE/files" ]; then
  cp -r "$GITHUB_WORKSPACE/files" ./
fi

# Hostname
sed -i 's/OpenWrt/OpenWrt-T7/g' ./package/base-files/files/etc/hostname

# LAN IP
sed -i 's/192.168.1.1/192.168.100.1/g' ./package/base-files/files/bin/config_generate

# 集客 AC
rm -rf package/openwrt-gecoosac
git clone --depth=1 https://github.com/lwb1978/openwrt-gecoosac package/openwrt-gecoosac

# rtp2httpd
rm -rf package/rtp2httpd
git clone --depth=1 https://github.com/stackia/rtp2httpd package/rtp2httpd

# vantage
rm -rf package/luci-app-vantage
git clone --depth=1 https://github.com/sirpdboy/luci-app-vantage package/luci-app-vantage

# store
rm -rf package/luci-app-store
git clone --depth=1 https://github.com/kenzok8/luci-app-store package/luci-app-store

# openclash
rm -rf package/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash package/luci-app-openclash

echo "==> done"
