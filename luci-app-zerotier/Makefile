include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-zerotier
PKG_VERSION:=1.3.2
PKG_RELEASE:=1

LUCI_TITLE:=LuCI for ZeroTier
LUCI_DEPENDS:=+zerotier
LUCI_PKGARCH:=all

define Package/luci-app-zerotier/conffiles
/etc/config/zerotier
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
