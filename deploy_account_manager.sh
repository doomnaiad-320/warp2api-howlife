#!/bin/bash

# 账号管理器部署脚本
# 适用于服务器环境

set -e  # 遇到错误立即退出

echo "🚀 部署账号管理器到服务器"
echo "================================"

# 配置
PORT=${PORT:-8021}
HOST=${HOST:-0.0.0.0}

# 检查必要文件
echo "📋 检查必要文件..."
REQUIRED_FILES=("proxy_server.py" "account.html")
MISSING_FILES=()

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        MISSING_FILES+=("$file")
    fi
done

if [ ${#MISSING_FILES[@]} -ne 0 ]; then
    echo "❌ 错误: 缺少必要文件:"
    printf '   - %s\n' "${MISSING_FILES[@]}"
    echo "请确保在正确的项目目录中运行此脚本"
    exit 1
fi

# 检查 Python 是否安装
if ! command -v python3 &> /dev/null; then
    echo "❌ 错误: 未找到 python3，请先安装 Python 3"
    exit 1
fi

# 创建requirements_proxy.txt（如果不存在）
if [ ! -f "requirements_proxy.txt" ]; then
    echo "📝 创建 requirements_proxy.txt..."
    cat > requirements_proxy.txt << EOF
flask>=2.0.0
flask-cors>=3.0.0
requests>=2.25.0
EOF
fi

# 安装依赖（直接安装，不使用虚拟环境）
echo "📥 安装依赖..."
pip3 install --user flask flask-cors requests

# 检查端口是否被占用
if command -v lsof &> /dev/null; then
    if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
        echo "⚠️  警告: 端口 $PORT 已被占用"
        echo "正在尝试停止占用该端口的进程..."
        
        # 尝试优雅停止
        PID=$(lsof -ti:$PORT)
        if [ ! -z "$PID" ]; then
            kill -TERM $PID 2>/dev/null || true
            sleep 2
            
            # 如果还在运行，强制停止
            if kill -0 $PID 2>/dev/null; then
                kill -KILL $PID 2>/dev/null || true
                echo "✅ 已停止占用端口的进程"
            fi
        fi
    fi
fi

# 创建日志目录
mkdir -p logs

# 启动服务器
echo "🌐 启动账号管理器..."
echo "📝 访问地址: http://localhost:$PORT/account.html"
echo "🔧 代理端点: http://localhost:$PORT/proxy/warp-token"
echo "⏹️  按 Ctrl+C 停止服务器"
echo ""

# 后台运行选项
if [ "$1" = "--daemon" ] || [ "$1" = "-d" ]; then
    echo "🔄 以守护进程模式启动..."
    nohup python3 proxy_server.py > logs/account-manager.log 2>&1 &
    PID=$!
    echo "✅ 服务已启动，PID: $PID"
    echo "📊 查看日志: tail -f logs/account-manager.log"
    echo "🛑 停止服务: kill $PID"
else
    # 前台运行
    python3 proxy_server.py
fi
