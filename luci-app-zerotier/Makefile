include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-zerotier
PKG_VERSION:=1.3.2
PKG_RELEASE:=2

LUCI_TITLE:=LuCI for ZeroTier
LUCI_DEPENDS:=
LUCI_PKGARCH:=all

define Package/luci-app-zerotier/conffiles
/etc/config/zerotier
endef

define Package/luci-app-zerotier/postinst
#!/bin/sh
if [ -z "${IPKG_INSTROOT}" ]; then
	echo "========================================"
	echo "  luci-app-zerotier 安装完成"
	echo "========================================"
	if ! command -v zerotier-one >/dev/null 2>&1; then
		echo ""
		echo "⚠️  提示：系统未检测到 zerotier 程序"
		echo "   请先通过以下方式安装 ZeroTier 后端："
		echo ""
		echo "   1) iStoreOS 商店搜索安装 ZeroTier"
		echo "   2) 或命令行: opkg update && opkg install zerotier"
		echo ""
		echo "   安装完成后请重启路由器或重新加载页面"
		echo "========================================"
	else
		echo ""
		echo "✅ zerotier 已存在，插件可正常使用"
		echo "   请刷新 LuCI 页面查看新界面"
		echo "========================================"
	fi
fi
exit 0
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
