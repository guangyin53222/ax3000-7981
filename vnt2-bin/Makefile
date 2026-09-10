include $(TOPDIR)/rules.mk

PKG_NAME:=vnt2-bin
PKG_VERSION:=2.0.7
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/vnt2-bin
  SECTION:=net
  CATEGORY:=Network
  TITLE:=VNT2 prebuilt binaries (cli/web/ctrl)
  DEPENDS:=@aarch64
endef

define Package/vnt2-bin/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/aarch64/vnt2_cli  $(1)/usr/bin/vnt2_cli
	$(INSTALL_BIN) ./files/aarch64/vnt2_web  $(1)/usr/bin/vnt2_web
	$(INSTALL_BIN) ./files/aarch64/vnt2_ctrl $(1)/usr/bin/vnt2_ctrl
endef

$(eval $(call BuildPackage,vnt2-bin))
