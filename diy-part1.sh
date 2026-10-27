#!/bin/bash
#
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Target: immortalwrt-mt798x-rebase @ 25.12
# Device: 360 T7

set -euo pipefail

# ===================== 开关配置 =====================
ADD_ISTORE="true"
ADD_OPENAPPFILTER="true"
ADD_HARBOR_FILE="true"
ADD_GECOOSAC="true"
ADD_TCPDUMP="true"
ADD_ARGON="false"          # false = 使用 Footstrap
ADD_FOOTSTRAP="true"
ADD_VANTAGE="true"

# ===================== 清理旧残留 =====================
echo "==> Cleaning old packages ..."
rm -rf \
  package/OpenAppFilter \
  package/luci-app-store \
  package/luci-app-gecoosac \
  package/luci-app-harbor-file \
  package/luci-app-tcpdump \
  package/luci-theme-argon \
  package/luci-app-argon-config \
  package/luci-theme-footstrap \
  package/luci-app-vantage

# ===================== iStore =====================
if [[ "${ADD_ISTORE}" == "true" ]]; then
  echo "==> Adding iStore feed ..."
  grep -q "^src-git istore" feeds.conf.default ||
    echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default
fi

# ===================== OpenAppFilter =====================
if [[ "${ADD_OPENAPPFILTER}" == "true" ]]; then
  echo "==> Cloning OpenAppFilter ..."
  git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter
fi

# ===================== Harbor File =====================
if [[ "${ADD_HARBOR_FILE}" == "true" ]]; then
  echo "==> Cloning Harbor File ..."
  git clone --depth=1 https://github.com/destan19/luci-app-harbor-file package/luci-app-harbor-file
fi

# ===================== Gecoos AC =====================
if [[ "${ADD_GECOOSAC}" == "true" ]]; then
  echo "==> Cloning Gecoos AC ..."
  git clone --depth=1 https://github.com/laipeng668/luci-app-gecoosac package/luci-app-gecoosac
fi

# ===================== luci-app-tcpdump =====================
if [[ "${ADD_TCPDUMP}" == "true" ]]; then
  echo "==> Cloning luci-app-tcpdump ..."
  git clone --depth=1 https://github.com/KFERMercer/luci-app-tcpdump.git package/luci-app-tcpdump
fi

# ===================== Footstrap（默认主题） =====================
if [[ "${ADD_FOOTSTRAP}" == "true" ]]; then
  echo "==> Cloning Footstrap theme ..."
  git clone --depth=1 https://github.com/VizzleTF/luci-theme-footstrap package/luci-theme-footstrap
fi

# ===================== Argon（可选） =====================
if [[ "${ADD_ARGON}" == "true" ]]; then
  echo "==> Cloning Argon theme ..."
  git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
  git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
fi

# ===================== Vantage（仪表盘，不带主题） =====================
if [[ "${ADD_VANTAGE}" == "true" ]]; then
  echo "==> Fetch luci-app-vantage ..."
  git clone --depth=1 https://github.com/anothaDev/luci-theme-vantage tmp-vantage
  mv tmp-vantage/luci-app-vantage package/luci-app-vantage
  rm -rf tmp-vantage
fi

echo "✅ diy-part1.sh finished."
