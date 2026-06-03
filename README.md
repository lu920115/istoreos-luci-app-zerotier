# istoreos-luci-app-zerotier

iStoreOS 定制版 luci-app-zerotier，基于 iStoreOS 商店安装的 1.3.0-1 版本修改。

## 版本信息

- 当前版本: **1.3.1-1**
- 基础版本: iStoreOS 1.3.0-1（从 iStore 商店安装）

## 功能特点

1. **保持原有界面完全不变**
   - TypedSection 表格形式的 Join Network（非 DynamicList）
   - 支持添加/删除多个网络
   - 每个网络可配置：Enabled、Network ID、Allow Managed、Allow Global、Allow Default、Allow DNS

2. **增加自建 ZeroTier 控制器支持**
   - "Self-hosted Controller URL" 输入框，默认填入 `http://192.168.5.88:28000`
   - "SAVE" 保存按钮，点击后保存 URL 到浏览器 localStorage
   - "OPEN SELF-HOSTED CONTROLLER" 跳转按钮，使用保存的 URL 打开
   - 位置在 Zerotier.com 按钮下方，Join Network 表格上方

## 安装方法

### 手动替换（推荐）

```bash
# 1. 备份原文件
cp /usr/lib/lua/luci/model/cbi/zerotier/settings.lua /tmp/settings.lua.bak

# 2. 上传新的 settings.lua 到路由器 /tmp

# 3. 替换文件
cp /tmp/settings.lua /usr/lib/lua/luci/model/cbi/zerotier/settings.lua

# 4. 清除缓存并重启 Web 服务
rm -f /tmp/luci-indexcache
rm -rf /tmp/luci-modulecache
/etc/init.d/nginx restart
/etc/init.d/uhttpd restart
```

## 文件结构

```
luci-app-zerotier/
├── Makefile                              # 包定义
├── luasrc/
│   ├── controller/zerotier.lua           # 控制器
│   ├── model/cbi/zerotier/
│   │   ├── settings.lua                  # 主配置界面（已修改）
│   │   └── info.lua                      # 接口信息
│   └── view/zerotier/zerotier_status.htm # 状态页面
└── root/
    ├── etc/init.d/luci_zerotier          # 启动脚本
    ├── etc/hotplug.d/net/25-luci-zerotier
    ├── usr/libexec/zerotier-nat          # NAT 辅助脚本
    ├── usr/libexec/zerotier-dns          # DNS 辅助脚本
    └── usr/share/nftables.d/             # 防火墙规则
```

## 上游源码

- iStoreOS: https://github.com/istoreos/istoreos
- iStore packages: https://github.com/linkease/istore-packages

## 许可证

Apache License 2.0
