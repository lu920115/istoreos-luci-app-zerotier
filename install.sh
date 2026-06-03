#!/bin/sh
# iStoreOS ZeroTier 插件界面升级脚本
# 在路由器上执行

echo "======================================"
echo "  ZeroTier 界面插件升级脚本 v1.0-21"
echo "======================================"
echo ""

# 检查是否以root运行
if [ "$(id -u)" != "0" ]; then
    echo "错误: 请使用 root 权限运行此脚本"
    exit 1
fi

# 步骤1: 备份
echo "[步骤1/5] 正在备份当前配置和文件..."
BACKUP_DIR="/tmp/zerotier-full-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# 备份配置文件
if [ -f /etc/config/zerotier ]; then
    cp /etc/config/zerotier "$BACKUP_DIR/zerotier.config"
    echo "  ✓ 配置文件已备份"
fi

# 备份LuCI界面文件
if [ -d /usr/lib/lua/luci/model/cbi/zerotier ]; then
    mkdir -p "$BACKUP_DIR/luci-cbi"
    cp -r /usr/lib/lua/luci/model/cbi/zerotier/* "$BACKUP_DIR/luci-cbi/"
    echo "  ✓ CBI界面文件已备份"
fi

if [ -d /usr/lib/lua/luci/view/zerotier ]; then
    mkdir -p "$BACKUP_DIR/luci-view"
    cp -r /usr/lib/lua/luci/view/zerotier/* "$BACKUP_DIR/luci-view/"
    echo "  ✓ View模板文件已备份"
fi

# 备份启动脚本
[ -f /etc/init.d/zerotier ] && cp /etc/init.d/zerotier "$BACKUP_DIR/"
[ -f /etc/zerotier.start ] && cp /etc/zerotier.start "$BACKUP_DIR/"
[ -f /etc/zerotier.stop ] && cp /etc/zerotier.stop "$BACKUP_DIR/"
[ -f /etc/uci-defaults/40_luci-zerotier ] && cp /etc/uci-defaults/40_luci-zerotier "$BACKUP_DIR/"
echo "  ✓ 启动脚本已备份"

# 打包备份
cd /tmp
tar czf "zerotier-full-backup-$(date +%Y%m%d-%H%M%S).tar.gz" "$(basename $BACKUP_DIR)" 2>/dev/null
echo "  ✓ 备份已打包到 /tmp/zerotier-full-backup-*.tar.gz"
echo ""

# 步骤2: 检查新文件
echo "[步骤2/5] 检查升级文件..."
if [ ! -f /tmp/settings.lua.new ]; then
    echo "错误: 找不到 /tmp/settings.lua.new"
    echo "请先将新的 settings.lua 上传到 /tmp/settings.lua.new"
    exit 1
fi
echo "  ✓ 新界面文件已找到"
echo ""

# 步骤3: 替换文件
echo "[步骤3/5] 替换界面文件..."
mkdir -p /usr/lib/lua/luci/model/cbi/zerotier
cp /tmp/settings.lua.new /usr/lib/lua/luci/model/cbi/zerotier/settings.lua
echo "  ✓ settings.lua 已更新"
echo ""

# 步骤4: 清除缓存
echo "[步骤4/5] 清除LuCI缓存..."
rm -f /tmp/luci-indexcache
rm -rf /tmp/luci-modulecache
/etc/init.d/uhttpd restart >/dev/null 2>&1
echo "  ✓ 缓存已清除，Web服务已重启"
echo ""

# 步骤5: 验证
echo "[步骤5/5] 验证安装..."
if [ -f /usr/lib/lua/luci/model/cbi/zerotier/settings.lua ]; then
    echo "  ✓ 新界面文件已安装"
    
    # 检查是否包含自建控制器配置
    if grep -q "selfhosted_url" /usr/lib/lua/luci/model/cbi/zerotier/settings.lua; then
        echo "  ✓ 自建控制器配置项已添加"
    fi
    
    if grep -q "Open Self-hosted Controller" /usr/lib/lua/luci/model/cbi/zerotier/settings.lua; then
        echo "  ✓ 自建控制器按钮已添加"
    fi
fi

echo ""
echo "======================================"
echo "  升级完成!"
echo "======================================"
echo ""
echo "请刷新浏览器页面查看新界面。"
echo ""
echo "备份位置: $BACKUP_DIR"
echo ""
echo "如需恢复，请运行:"
echo "  sh /tmp/restore.sh $BACKUP_DIR"
echo ""
