# luci-app-zerotier v1.0-21 for iStoreOS / OpenWrt

[English](#english) | [中文](#中文)

---

## 中文

基于 [coolsnowwolf/luci](https://github.com/coolsnowwolf/luci) 的 luci-app-zerotier 修改版，适配 iStoreOS 及其他 OpenWrt 衍生系统。

### 主要改进

1. **增加自建 ZeroTier 控制器支持**
   - 新增 "Self-hosted Controller URL" 输入框，可配置任意自建控制器地址
   - 新增 "Open Self-hosted Controller" 按钮，一键跳转
   - 不依赖固定 IP，灵活配置

2. **版本升级**
   - 版本号: v1.0-21

### 安装方法

#### 方法一：一键安装（推荐）

```bash
# 1. 将 install.sh 和新的 settings.lua 上传到路由器 /tmp
# 2. 执行安装脚本
sh /tmp/install.sh
```

#### 方法二：手动替换

```bash
# 1. 备份原文件
cp /usr/lib/lua/luci/model/cbi/zerotier/settings.lua /tmp/settings.lua.bak

# 2. 替换文件
cp /tmp/settings.lua /usr/lib/lua/luci/model/cbi/zerotier/settings.lua

# 3. 清除缓存
rm -f /tmp/luci-indexcache
/etc/init.d/uhttpd restart
```

### 恢复方法

```bash
# 使用恢复脚本
sh /tmp/restore.sh /tmp/zerotier-full-backup-XXXXXX
```

### 文件说明

```
luci-app-zerotier/
├── Makefile                              # 包定义
├── luasrc/
│   ├── model/cbi/zerotier/settings.lua   # 主配置界面
│   └── view/zerotier/zerotier_status.htm # 状态页面
└── root/
    ├── etc/init.d/zerotier               # 启动脚本
    ├── etc/uci-defaults/40_luci-zerotier # 初始化
    ├── etc/zerotier.start                # NAT规则
    └── etc/zerotier.stop                 # 停止清理
```

### 上游源码

- https://github.com/coolsnowwolf/luci/tree/master/applications/luci-app-zerotier

### 许可证

Apache License 2.0

---

## English

Modified luci-app-zerotier based on [coolsnowwolf/luci](https://github.com/coolsnowwolf/luci), adapted for iStoreOS and other OpenWrt-based systems.

### Features

1. **Self-hosted ZeroTier Controller Support**
   - New "Self-hosted Controller URL" input field
   - New "Open Self-hosted Controller" button
   - Flexible configuration, not tied to fixed IP

2. **Version Bump**
   - Version: v1.0-21

### Installation

#### Method 1: One-click Install (Recommended)

```bash
# 1. Upload install.sh and new settings.lua to router /tmp
# 2. Run install script
sh /tmp/install.sh
```

#### Method 2: Manual Replace

```bash
# 1. Backup original
cp /usr/lib/lua/luci/model/cbi/zerotier/settings.lua /tmp/settings.lua.bak

# 2. Replace
cp /tmp/settings.lua /usr/lib/lua/luci/model/cbi/zerotier/settings.lua

# 3. Clear cache
rm -f /tmp/luci-indexcache
/etc/init.d/uhttpd restart
```

### Restore

```bash
sh /tmp/restore.sh /tmp/zerotier-full-backup-XXXXXX
```

### Upstream

- https://github.com/coolsnowwolf/luci/tree/master/applications/luci-app-zerotier

### License

Apache License 2.0
