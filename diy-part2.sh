#!/bin/bash
#
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Target: immortalwrt-mt798x-rebase @ 25.12
#

# ===================== 修改默认 IP → 192.168.100.1 =====================
sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# ===================== 修改主机名 =====================
sed -i 's/ImmortalWrt/ARWRT/g' package/base-files/files/bin/config_generate

# ===================== 默认主题：Argon =====================
mkdir -p package/base-files/files/etc/uci-defaults
cat << 'EOF' > package/base-files/files/etc/uci-defaults/99-default-theme
#!/bin/sh
uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-default-theme

# ===================== OpenClash 强制 binary core =====================
sed -i 's/^CONFIG_OPENCLASH_CORE_TYPE=.*/CONFIG_OPENCLASH_CORE_TYPE="binary"/' .config

# ===================== 关闭 YJIT（防止 OOM） =====================
sed -i 's/^CONFIG_RUBY_ENABLE_YJIT=y/# CONFIG_RUBY_ENABLE_YJIT is not set/' .config

# ===================== VNT2：拉取LuCI管理面板，核心二进制手动放入files =====================
rm -rf package/luci-app-vnt2
git clone https://github.com/guangyin53222/luci-app-vnt2 package/luci-app-vnt2

# 给files内VNT二进制补齐执行权限【关键，防止windows上传丢失权限】
chmod +x files/usr/bin/vnt2_cli files/usr/bin/vnt2_ctrl

echo "diy-part2.sh done."
