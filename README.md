# istoreos-luci-app-zerotier

iStoreOS 定制版 luci-app-zerotier，基于 iStoreOS 商店安装的 1.3.0-1 版本修改。

## 版本信息

- 当前版本: **1.3.2-4**
- 基础版本: iStoreOS 1.3.0-1（从 iStore 商店安装）
- 测试平台: iStoreOS x86 小主机
- 架构支持: **all** — x86 / ARM / MIPS 全平台通用
- 兼容版本: iStoreOS 24.10 分支
- 依赖: 无硬依赖，但需要配合 zerotier 后端使用

## 功能特点

1. **保持原有界面完全不变**
   - TypedSection 表格形式的 Join Network（非 DynamicList）
   - 支持添加/删除多个网络
   - 每个网络可配置：Enabled、Network ID、Allow Managed、Allow Global、Allow Default、Allow DNS

2. **增加自建 ZeroTier 控制器支持**
   - "Self-hosted Controller URL" 输入框，默认填入 `http://192.168.5.88:28000`
   - "SAVE" 按钮，点击后弹出模态框显示当前 URL 并提示："请点击右下角的保持并应用才能永久为自己的url"
   - "OPEN SELF-HOSTED CONTROLLER" 跳转按钮，在新窗口打开输入的 URL
   - 位置在 Zerotier.com 按钮下方，Join Network 表格上方

## 安装方法

### 方式一：直接安装 .ipk 包

从 [GitHub Releases](https://github.com/lu920115/istoreos-luci-app-zerotier/releases) 下载 .ipk 文件，然后：
```bash
wget https://github.com/lu920115/istoreos-luci-app-zerotier/releases/download/v1.3.2-2/luci-app-zerotier_1.3.2-2_all.ipk
opkg install luci-app-zerotier_1.3.2-2_all.ipk
```

> 注意：本包不含 zerotier 后端程序。如果系统没有 zerotier，安装后会自动提示你先去 iStore 商店安装 ZeroTier。

### 方式二：手动替换（推荐）

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
