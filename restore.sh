#!/bin/sh
# iStoreOS ZeroTier 插件一键恢复脚本

RESTORE_DIR="$1"

if [ -z "$RESTORE_DIR" ]; then
    echo "用法: $0 <备份目录>"
    echo "例如: $0 /tmp/zerotier-full-backup-20250603-123456"
    exit 1
fi

if [ ! -d "$RESTORE_DIR" ]; then
    echo "错误: 备份目录不存在: $RESTORE_DIR"
    exit 1
fi

echo "======================================"
echo "  ZeroTier 插件恢复脚本"
echo "======================================"
echo ""
echo "恢复源: $RESTORE_DIR"
echo ""

# 1. 停止服务
echo "[步骤1/4] 停止 zerotier 服务..."
/etc/init.d/zerotier stop 2>/dev/null
sleep 2
echo "  ✓ 服务已停止"

# 2. 恢复配置文件
echo "[步骤2/4] 恢复配置文件..."
if [ -f "$RESTORE_DIR/zerotier.config" ]; then
    cp "$RESTORE_DIR/zerotier.config" /etc/config/zerotier
    echo "  ✓ 配置文件已恢复"
fi

# 3. 恢复界面文件
echo "[步骤3/4] 恢复LuCI界面文件..."
if [ -d "$RESTORE_DIR/luci-cbi" ]; then
    mkdir -p /usr/lib/lua/luci/model/cbi/zerotier
    cp -r "$RESTORE_DIR/luci-cbi/"* /usr/lib/lua/luci/model/cbi/zerotier/
    echo "  ✓ CBI文件已恢复"
fi

if [ -d "$RESTORE_DIR/luci-view" ]; then
    mkdir -p /usr/lib/lua/luci/view/zerotier
    cp -r "$RESTORE_DIR/luci-view/"* /usr/lib/lua/luci/view/zerotier/
    echo "  ✓ View文件已恢复"
fi

# 4. 重启服务
echo "[步骤4/4] 重启服务..."
rm -f /tmp/luci-indexcache
/etc/init.d/uhttpd restart >/dev/null 2>&1
sleep 1
/etc/init.d/zerotier start
echo "  ✓ 服务已重启"

echo ""
echo "======================================"
echo "  恢复完成!"
echo "======================================"
echo ""
echo "请刷新浏览器页面。"
