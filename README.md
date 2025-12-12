# EZ-Service ⚡

> 让服务管理像喝水一样简单！一个脚本搞定启停、监控、清理，妈妈再也不用担心我的服务管理了~

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/TwinsenLiang/ez-service)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Shell](https://img.shields.io/badge/shell-bash-orange.svg)](https://www.gnu.org/software/bash/)

## 🎯 这是啥？

你是不是经常遇到这些烦心事：
- 😫 启动服务时端口被占用了？
- 😱 停止服务后进程还在耍赖不走？
- 🤔 服务挂了？还是活着？一脸懵逼？
- 😤 每个项目的启动脚本都长得不一样？

**EZ-Service 来拯救你！**

一个统一的服务管理脚本模板，让你的所有项目都能：
- ✅ 一键启停，干净利落
- ✅ 端口冲突？自动检测！
- ✅ 僵尸进程？一键清理！
- ✅ 服务状态？一目了然！
- ✅ 访问地址？自动显示！

## 🚀 快速开始

### 30 秒上手

```bash
# 1. 复制到你的项目
cp ez-service/service.sh your-project/service.sh

# 2. 改个配置（服务名、端口号啥的）
vim your-project/service.sh  # 前 53 行

# 3. 开始使用
./service.sh start   # 嗖~ 服务跑起来了！
```

### 命令全家桶

```bash
./service.sh start      # 🚀 启动服务
./service.sh stop       # 🛑 停止服务
./service.sh restart    # 🔄 重启服务
./service.sh status     # 📊 查看状态
./service.sh logs       # 📜 实时日志
./service.sh cleanup    # 🧹 清理僵尸
./service.sh help       # ❓ 求助热线
```

## ✨ 核心功能

### 🎮 智能端口管理

启动前自动检查端口，谁占了我的端口？一目了然！

```bash
$ ./service.sh start
检查端口 5000 可用性...
✗ 端口 5000 已被占用！

占用进程信息:
  python3   12345 user   TCP *:5000 (LISTEN)

解决方案：
  1. 修改本项目的 SERVICE_PORT 为其他端口
  2. 停止占用该端口的其他服务
  3. 使用 ./service.sh cleanup 清理僵尸进程
```

### 🧹 僵尸进程终结者

服务挂了但进程还在占着端口？cleanup 命令帮你清理干净！

```bash
$ ./service.sh cleanup
清理 PID 文件中的进程 (4321)...
清理端口 5000 占用进程...
  已清理进程: 4321

✓ 清理完成
```

### 📡 自动显示访问地址

启动服务后自动告诉你怎么访问，再也不用记端口号！

```bash
$ ./service.sh start
✓ 服务启动成功!
  PID: 5678

📡 访问地址:
  本地访问: http://localhost:5000
  局域网访问: http://192.168.1.100:5000

管理命令:
  ./service.sh status - 查看状态
  ./service.sh logs   - 查看日志
  ./service.sh stop   - 停止服务
```

### 📊 服务状态一览

CPU、内存、端口监听状态，该有的都有！

```bash
$ ./service.sh status
服务状态: ✓ 正在运行
进程ID: 5678
启动时间: Fri Dec 13 10:30:00 2025
CPU使用: 2.5%
内存使用: 1.2%

📡 访问地址:
  本地访问: http://localhost:5000
  局域网访问: http://192.168.1.100:5000

端口监听状态:
  端口 5000: ✓ 正在监听
```

## 🎨 配置超简单

只需要改前 53 行的配置变量，通用功能代码（54 行之后）**完全不用动**！

```bash
# 服务显示名称
SERVICE_NAME="我的超棒服务"

# 启动命令
START_CMD="python3 app.py"

# 服务端口（⚠️ Web 服务必须设置）
SERVICE_PORT="5000"

# 是否启用 Python 虚拟环境
USE_VENV="true"
```

## 🏗️ 架构哲学

**品牌标准 + 产品差异化**

就像麦当劳的汉堡，有统一标准，但每个店可以有当地特色：

- 📋 **模板（品牌标准）**: 定义通用功能和标准
- 🎨 **项目实例（产品特色）**: 可以独立修改和差异化
- 🔄 **提升机制**: 多个项目都需要的功能 → 提升到模板

## 🔧 批量更新

修改了模板？一键同步到所有项目！

```bash
cd ez-service
./update.sh  # 自动更新所有配置的项目
```

## 📚 支持的环境

- ✅ **Python** 项目（Flask、FastAPI、Django...）
- ✅ **Node.js** 项目（Express、Koa...）
- ✅ **Go** 项目
- ✅ **Java** 项目
- ✅ 任何需要后台运行的服务！

## 🤝 贡献

发现 Bug？有好点子？欢迎提 Issue 或 PR！

1. Fork 本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交改动 (`git commit -m '增加了超棒的功能'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开个 Pull Request

## 📝 更新日志

查看 [CHANGELOG.md](CHANGELOG.md) 了解版本历史和变更。

## 📄 许可证

MIT License - 随便用，但记得留个名 😊

查看 [LICENSE](LICENSE) 文件了解详情。

## 🎉 致谢

感谢所有使用 EZ-Service 的小伙伴们！让服务管理变得更简单是我们的目标！

---

**Made with ❤️ and ☕ by TwinsenLiang**

如果觉得有用，给个 Star ⭐ 呗！
