# Roadmap 🗺️

> EZ-Service 的发展路线图 - 让服务管理越来越简单！

## 📍 当前状态

**版本**: v1.0.0
**发布日期**: 2025-12-13
**状态**: ✅ 已发布

### 已完成的功能

- ✅ 一键启停管理
- ✅ 端口冲突检测
- ✅ 僵尸进程清理
- ✅ 服务状态监控
- ✅ URL 自动显示
- ✅ 批量更新工具
- ✅ Python 虚拟环境支持
- ✅ 依赖自动安装

---

## 🚀 未来计划

### v1.1.0 - systemctl 融合 🎯

**预计时间**: Q1 2026
**优先级**: ⭐⭐⭐⭐⭐

#### 核心目标

将 EZ-Service 与 Linux systemd/systemctl 无缝集成，让用户可以：
- 保持 EZ-Service 的简单易用
- 享受 systemctl 的强大功能
- 两种方式自由切换

#### 功能规划

**1. 自动生成 systemd 服务文件**

```bash
./service.sh install-systemd
# 自动生成 /etc/systemd/system/your-service.service
# 保留所有配置，直接转换为 systemd 格式
```

生成的服务文件示例：
```ini
[Unit]
Description=Your Service Name
After=network.target

[Service]
Type=simple
User=your-user
WorkingDirectory=/path/to/project
ExecStart=/path/to/venv/bin/python app.py
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
```

**2. systemctl 命令兼容层**

```bash
./service.sh start      # 检测 systemd，自动选择最佳方式
./service.sh status     # 如果安装了 systemd 服务，显示 systemctl 状态
./service.sh enable     # 新增：设置开机自启
./service.sh disable    # 新增：取消开机自启
```

**3. 混合模式**

- 开发环境：使用 PID 文件模式（快速、灵活）
- 生产环境：使用 systemctl 模式（可靠、标准）
- 一个命令切换：`./service.sh mode [pid|systemd]`

**4. 迁移工具**

```bash
./service.sh migrate-to-systemd    # 平滑迁移到 systemd
./service.sh migrate-from-systemd  # 回退到 PID 模式
```

#### 架构设计

```
service.sh
├── 配置层（保持不变）
├── 检测层（新增）
│   ├── 检测是否有 systemd
│   ├── 检测是否已安装为 systemd 服务
│   └── 检测当前运行模式
├── 执行层（增强）
│   ├── PID 模式（现有）
│   └── systemctl 模式（新增）
└── 管理层（增强）
    ├── 安装/卸载 systemd 服务
    ├── 模式切换
    └── 迁移工具
```

#### 实现细节

1. **向后兼容**：旧版本脚本 100% 兼容
2. **零配置**：自动检测，智能选择
3. **渐进增强**：没有 systemd？照样工作！
4. **用户选择**：可以手动指定使用哪种模式

#### 技术挑战

- [ ] systemd 服务文件模板设计
- [ ] 权限问题处理（systemctl 需要 sudo）
- [ ] 日志整合（journalctl vs 本地日志）
- [ ] 跨平台兼容（macOS 没有 systemd）
- [ ] 配置迁移逻辑

---

### v1.2.0 - 监控与告警 📊

**预计时间**: Q2 2026
**优先级**: ⭐⭐⭐⭐

#### 功能点

- 🔍 健康检查（HTTP/TCP 端口探测）
- 📈 资源监控（CPU/内存阈值告警）
- 🔄 自动重启（崩溃后自动恢复）
- 📧 告警通知（邮件/Webhook）
- 📊 性能日志（记录资源使用历史）

#### 示例

```bash
# service.sh 配置
HEALTH_CHECK_URL="http://localhost:5000/health"
HEALTH_CHECK_INTERVAL=30  # 秒
AUTO_RESTART=true
CPU_THRESHOLD=80          # %
MEMORY_THRESHOLD=80       # %
ALERT_EMAIL="admin@example.com"
ALERT_WEBHOOK="https://hooks.slack.com/..."
```

---

### v1.3.0 - 多服务编排 🎭

**预计时间**: Q3 2026
**优先级**: ⭐⭐⭐

#### 功能点

- 📦 服务组管理（一键启停多个服务）
- 🔗 依赖关系（按顺序启动/停止）
- 🌊 配置文件（类 docker-compose）

#### 示例

```yaml
# services.yml
services:
  database:
    script: ./db/service.sh
    priority: 1

  backend:
    script: ./api/service.sh
    depends_on: [database]
    priority: 2

  frontend:
    script: ./web/service.sh
    depends_on: [backend]
    priority: 3
```

```bash
./service-compose start    # 按顺序启动所有服务
./service-compose stop     # 反向顺序停止
./service-compose status   # 查看所有服务状态
```

---

### v2.0.0 - Web UI 仪表板 🖥️

**预计时间**: Q4 2026
**优先级**: ⭐⭐⭐

#### 功能点

- 🌐 Web 界面管理所有服务
- 📊 实时监控图表
- 📜 日志查看器
- ⚙️ 配置编辑器
- 👥 多用户权限管理

---

## 🎯 长期愿景

### 生态系统

- 📚 插件系统（自定义功能）
- 🏪 插件市场（社区贡献）
- 🔌 集成第三方工具（Docker、K8s、云服务）

### 跨平台

- ✅ Linux（systemd）
- ✅ macOS（launchd 支持？）
- ❓ Windows（NSSM 集成？）

### 社区

- 📖 详细教程和最佳实践
- 🎥 视频教程
- 💬 Discord/Telegram 社区
- 🏆 贡献者计划

---

## 💡 想法池

这些是还在考虑中的功能，欢迎投票和讨论！

### 正在考虑

- 🔐 配置加密（敏感信息保护）
- 🌍 多语言支持（国际化）
- 🐳 Docker 容器支持
- 📱 移动端 App（远程管理）
- 🤖 ChatOps 集成（Slack/Discord）
- 📊 Prometheus 指标导出
- 🔄 蓝绿部署支持
- 🎯 流量切换（负载均衡）

### 等待社区反馈

- ❓ 你最想要什么功能？
- ❓ 遇到了什么痛点？
- ❓ 有什么改进建议？

**提交你的想法**: [GitHub Discussions](https://github.com/TwinsenLiang/ez-service/discussions)

---

## 📊 版本策略

### 语义化版本

- **MAJOR (x.0.0)**: 重大架构变更，可能不兼容
- **MINOR (1.x.0)**: 新功能，向后兼容
- **PATCH (1.0.x)**: Bug 修复，向后兼容

### 发布周期

- 🐛 **Patch**: 按需发布（发现 Bug 立即修复）
- ✨ **Minor**: 季度发布（每 3 个月）
- 🚀 **Major**: 年度发布（重大变革）

---

## 🤝 如何参与

### 贡献代码

1. Fork 项目
2. 创建功能分支
3. 提交 PR
4. 等待 Review

### 提供反馈

- 🐛 报告 Bug
- 💡 提出新功能建议
- 📝 改进文档
- ⭐ 给项目 Star

### 讨论交流

- GitHub Discussions
- Issue 区
- 邮件列表（即将开放）

---

## 📅 里程碑

| 版本 | 目标日期 | 状态 | 重点功能 |
|------|---------|------|---------|
| v1.0.0 | 2025-12-13 | ✅ 完成 | 基础服务管理 |
| v1.1.0 | 2026 Q1 | 🎯 规划中 | systemctl 融合 |
| v1.2.0 | 2026 Q2 | 📝 待定 | 监控告警 |
| v1.3.0 | 2026 Q3 | 📝 待定 | 多服务编排 |
| v2.0.0 | 2026 Q4 | 📝 待定 | Web UI |

---

## 💬 联系我们

- **GitHub**: [@TwinsenLiang](https://github.com/TwinsenLiang)
- **Email**: 通过 GitHub Profile
- **Issues**: [提交问题](https://github.com/TwinsenLiang/ez-service/issues)
- **Discussions**: [参与讨论](https://github.com/TwinsenLiang/ez-service/discussions)

---

**最后更新**: 2025-12-13
**维护者**: TwinsenLiang

让我们一起让服务管理越来越简单！⚡
