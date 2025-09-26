#!/bin/bash

# 账号管理器代理服务器启动脚本
# 适用于生产环境部署

set -e  # 遇到错误立即退出

echo "🚀 启动账号管理器代理服务器"
echo "================================"

# 配置
PORT=${PORT:-8021}
HOST=${HOST:-0.0.0.0}
WORKERS=${WORKERS:-4}

# 检查 Python 是否安装
if ! command -v python3 &> /dev/null; then
    echo "❌ 错误: 未找到 python3，请先安装 Python 3"
    exit 1
fi

# 检查必要文件是否存在
if [ ! -f "proxy_server.py" ]; then
    echo "❌ 错误: 未找到 proxy_server.py 文件"
    exit 1
fi

if [ ! -f "account.html" ]; then
    echo "❌ 错误: 未找到 account.html 文件"
    exit 1
fi

# 安装依赖
echo "📦 检查并安装依赖..."
pip3 install --user flask flask-cors requests gunicorn

# 创建日志目录
mkdir -p logs

# 检查端口是否被占用
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null ; then
    echo "⚠️  警告: 端口 $PORT 已被占用"
    echo "请修改 PORT 环境变量或停止占用该端口的进程"
    exit 1
fi

echo "🌐 启动服务器..."
echo "📝 访问地址: http://localhost:$PORT/account.html"
echo "🔧 代理端点: http://localhost:$PORT/proxy/warp-token"
echo "📊 工作进程: $WORKERS"
echo "⏹️  按 Ctrl+C 停止服务器"
echo ""

# 生产环境使用 gunicorn
if command -v gunicorn &> /dev/null; then
    echo "🔧 使用 Gunicorn 启动生产服务器..."
    gunicorn --bind $HOST:$PORT \
             --workers $WORKERS \
             --worker-class sync \
             --timeout 120 \
             --keepalive 5 \
             --max-requests 1000 \
             --max-requests-jitter 100 \
             --access-logfile logs/access.log \
             --error-logfile logs/error.log \
             --log-level info \
             --capture-output \
             proxy_server:app
else
    echo "🔧 使用 Flask 开发服务器..."
    echo "⚠️  注意: 生产环境建议安装 gunicorn"
    python3 proxy_server.py
fi
