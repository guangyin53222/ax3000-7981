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

# ===================== VNT2：拉取LuCI网页插件 =====================
rm -rf package/luci-app-vnt2
git clone https://github.com/guangyin53222/luci-app-vnt2 package/luci-app-vnt2

# 给files内VNT二进制补齐执行权限【Windows上传丢失权限修复】
chmod +x files/usr/bin/vnt2_cli files/usr/bin/vnt2_ctrl
# uci-defaults配置文件权限
chmod +x files/etc/uci-defaults/99-vnt-init

# ========== 固化VNT防火墙规则（刷完固件自动添加vnt防火墙zone，解决飞牛连不上的核心坑） ==========
cat << 'EOF' > files/etc/uci-defaults/99-vnt-firewall
#!/bin/sh
# 新建vnt防火墙区域
uci add firewall zone
uci set firewall.@zone[-1].name='vnt'
uci set firewall.@zone[-1].network='tun-vnt'
uci set firewall.@zone[-1].input='ACCEPT'
uci set firewall.@zone[-1].output='ACCEPT'
uci set firewall.@zone[-1].forward='ACCEPT'

# LAN <-> VNT双向转发
uci add firewall forwarding
uci set firewall.@forwarding[-1].src='lan'
uci set firewall.@forwarding[-1].dest='vnt'

uci add firewall forwarding
uci set firewall.@forwarding[-1].src='vnt'
uci set firewall.@forwarding[-1].dest='lan'

uci commit firewall
exit 0
EOF
chmod +x files/etc/uci-defaults/99-vnt-firewall

echo "diy-part2.sh done."
