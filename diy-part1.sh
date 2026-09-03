#!/bin/bash
#
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Target: immortalwrt-mt798x-rebase @ 25.12
#

# ===================== 清理旧残留 =====================
rm -rf package/OpenAppFilter
rm -rf package/luci-app-store
rm -rf package/luci-app-gecoosac
rm -rf package/luci-app-harbor-file
rm -rf package/luci-app-tcpdump
rm -rf package/luci-theme-argon
rm -rf package/luci-app-argon-config

# ===================== iStore（官方标准方式 ✅） =====================
grep -q "src-git istore" feeds.conf.default || \
echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default

# ===================== OpenAppFilter（仅 luci，不编内核） =====================
git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter

# ===================== Harbor File（文件管理器） =====================
git clone --depth=1 https://github.com/destan19/luci-app-harbor-file package/luci-app-harbor-file

# ===================== Gecoos AC（集客 AC） =====================
git clone --depth=1 https://github.com/laipeng668/luci-app-gecoosac package/luci-app-gecoosac

# ===================== tcpdump（抓包插件） =====================
git clone --depth=1 https://github.com/KFERMercer/luci-app-tcpdump.git package/luci-app-tcpdump

# ===================== Argon 主题 + 配置插件 =====================
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# ===================== 不要在这里执行 feeds update/install =====================
echo "diy-part1.sh done."
