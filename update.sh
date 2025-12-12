#!/bin/bash

# ============================================================
# Service Manager 批量更新脚本
# ============================================================
#
# 功能：批量更新所有项目的 service.sh
# 原理：保留各项目配置（前 53 行），更新通用代码（54 行之后）
#

set -e  # 遇到错误立即退出

echo "=========================================="
echo "Service Manager - 批量更新脚本"
echo "=========================================="
echo ""

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_FILE="$SCRIPT_DIR/service.sh"

# 检查模板文件是否存在
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "✗ 错误: 模板文件不存在: $TEMPLATE_FILE"
    exit 1
fi

# 定义要更新的项目列表
# 格式: "项目路径"
PROJECTS=(
    # 本地 Mac 项目
    "$HOME/Sites/learnpsai/scripts/service.sh"
    "$HOME/Sites/SlowMovie/service.sh"
    "$HOME/Sites/auto_svg_generator/service.sh"
)

# RaspberryPi5 项目（需要 SSH）
RPI5_HOST="twinsenliang@192.168.50.129"
RPI5_PROJECTS=(
    "~/Sites/product-svg-generator/service.sh"
    "~/Sites/infrared_remote_mark/service.sh"
)

echo "当前模板版本: $(cat "$SCRIPT_DIR/version")"
echo ""

# 询问用户确认
read -p "是否继续更新所有项目？(y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "已取消更新"
    exit 0
fi

echo ""
echo "开始更新本地项目..."
echo ""

# 更新本地项目
SUCCESS_COUNT=0
FAIL_COUNT=0

for project_file in "${PROJECTS[@]}"; do
    if [ -f "$project_file" ]; then
        echo "更新: $project_file"

        # 保留配置（前 53 行）
        head -n 53 "$project_file" > "${project_file}.tmp"

        # 添加通用代码（54 行之后）
        tail -n +54 "$TEMPLATE_FILE" >> "${project_file}.tmp"

        # 替换原文件
        mv "${project_file}.tmp" "$project_file"
        chmod +x "$project_file"

        echo "  ✓ 更新成功"
        ((SUCCESS_COUNT++))
    else
        echo "  ✗ 文件不存在: $project_file"
        ((FAIL_COUNT++))
    fi
    echo ""
done

echo ""
echo "是否更新 RaspberryPi5 上的项目？"
read -p "需要 SSH 连接 $RPI5_HOST (y/N) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "开始更新 RaspberryPi5 项目..."
    echo ""

    # 先传输模板到 RaspberryPi5
    echo "传输模板到 RaspberryPi5..."
    scp "$TEMPLATE_FILE" "$RPI5_HOST:~/service.sh.template"
    echo "  ✓ 模板已传输"
    echo ""

    # 更新 RaspberryPi5 项目
    for project_file in "${RPI5_PROJECTS[@]}"; do
        echo "更新: $RPI5_HOST:$project_file"

        ssh "$RPI5_HOST" bash << EOF
if [ -f "$project_file" ]; then
    head -n 53 "$project_file" > "${project_file}.tmp"
    tail -n +54 ~/service.sh.template >> "${project_file}.tmp"
    mv "${project_file}.tmp" "$project_file"
    chmod +x "$project_file"
    echo "  ✓ 更新成功"
else
    echo "  ✗ 文件不存在: $project_file"
    exit 1
fi
EOF

        if [ $? -eq 0 ]; then
            ((SUCCESS_COUNT++))
        else
            ((FAIL_COUNT++))
        fi
        echo ""
    done

    # 清理临时文件
    ssh "$RPI5_HOST" "rm -f ~/service.sh.template"

    # 更新 RaspberryPi5 上的模板
    echo "更新 RaspberryPi5 模板..."
    scp "$TEMPLATE_FILE" "$RPI5_HOST:~/Sites/service.sh"
    ssh "$RPI5_HOST" "chmod +x ~/Sites/service.sh"
    echo "  ✓ RaspberryPi5 模板已更新"
    echo ""
fi

echo "=========================================="
echo "更新完成"
echo "=========================================="
echo "成功: $SUCCESS_COUNT 个项目"
echo "失败: $FAIL_COUNT 个项目"
echo ""
