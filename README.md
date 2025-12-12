# Service Manager

统一的服务管理脚本模板，用于所有项目的服务启停控制。

## 版本

**当前版本**: v1.0.0

## 功能特性

- ✅ 服务启动/停止/重启管理
- ✅ 服务状态查看（进程、端口、资源使用）
- ✅ 实时日志查看
- ✅ 端口冲突检测
- ✅ 端口占用自动清理
- ✅ 僵尸进程清理
- ✅ Python 虚拟环境支持
- ✅ 依赖自动安装
- ✅ 测试程序运行

## 使用方法

### 1. 复制到新项目

```bash
cp ~/Sites/service-manager/service.sh <你的项目目录>/service.sh
chmod +x <你的项目目录>/service.sh
```

### 2. 配置项目参数

编辑 `service.sh` 前 53 行的配置变量：

```bash
# 服务显示名称
SERVICE_NAME="你的服务名称"

# 应用名称（用于标识）
APP_NAME="your_app"

# PID 文件路径
PID_FILE="app.pid"

# 日志文件路径
LOG_FILE="logs/app.log"

# 启动命令
START_CMD="python3 app.py"

# 服务端口（⚠️ Web 服务必须设置）
SERVICE_PORT="5000"

# 是否启用 Python 虚拟环境
USE_VENV="true"

# 是否需要检查依赖
CHECK_DEPS="true"

# 依赖文件路径
DEPS_FILE="requirements.txt"
```

### 3. 使用命令

```bash
./service.sh start      # 启动服务
./service.sh stop       # 停止服务
./service.sh restart    # 重启服务
./service.sh status     # 查看状态
./service.sh logs       # 查看日志
./service.sh cleanup    # 清理僵尸进程
./service.sh test       # 运行测试
./service.sh help       # 显示帮助
```

## 架构原则

**品牌标准 + 产品差异化**

- **模板（品牌标准）**: `~/Sites/service-manager/service.sh`
  - 定义通用功能和标准
  - 所有项目的共性需求

- **项目实例（产品特性）**: `<项目>/service.sh`
  - 可以独立修改和差异化
  - 适应项目特殊需求

- **提升机制**:
  - 多个项目出现相同需求 → 提升到模板
  - 模板更新 → 选择性同步到项目

## 更新项目

### 手动更新单个项目

```bash
# 保留配置（前 53 行），更新功能代码（54 行之后）
cd <项目目录>
head -n 53 service.sh > service.sh.tmp
tail -n +54 ~/Sites/service-manager/service.sh >> service.sh.tmp
mv service.sh.tmp service.sh
chmod +x service.sh
```

### 批量更新（使用 update.sh）

```bash
cd ~/Sites/service-manager
./update.sh  # 自动更新所有配置的项目
```

## 版本管理

### 查看历史

```bash
git log --oneline
git tag -l
```

### 创建新版本

```bash
# 修改代码
vim service.sh

# 更新 CHANGELOG.md
vim CHANGELOG.md

# 提交变更
git add .
git commit -m "feat: 添加新功能"
git tag v1.1.0
```

### 回滚到旧版本

```bash
# 查看版本
git tag -l

# 回滚到指定版本
git checkout v1.0.0 service.sh
```

## 开发规范

### 修改模板

1. 在 `service-manager` 目录修改 `service.sh`
2. 测试验证修改
3. 更新 `CHANGELOG.md`
4. Git commit 并打 tag
5. 同步到需要的项目

### 配置区域

- **第 20-48 行**: 项目配置变量
- **第 54 行之后**: 通用功能代码（一般不修改）

## 当前管理的项目

### 本地 Mac

- `~/Sites/learnpsai/scripts/service.sh`
- `~/Sites/SlowMovie/service.sh`
- `~/Sites/auto_svg_generator/service.sh`

### RaspberryPi5

- `~/Sites/service.sh` (模板)
- `~/Sites/product-svg-generator/service.sh`
- `~/Sites/infrared_remote_mark/service.sh`

## 技术支持

遇到问题？

1. 查看日志：`./service.sh logs`
2. 检查状态：`./service.sh status`
3. 清理残留：`./service.sh cleanup`
4. 查看帮助：`./service.sh help`

## 许可证

内部项目使用
