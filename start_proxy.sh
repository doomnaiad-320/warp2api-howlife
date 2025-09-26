#!/bin/bash

echo "🚀 启动账号管理器代理服务器"
echo "================================"

# 检查 Python 是否安装
if ! command -v python3 &> /dev/null; then
    echo "❌ 错误: 未找到 python3，请先安装 Python 3"
    exit 1
fi

# 检查是否存在虚拟环境
if [ ! -d "venv_proxy" ]; then
    echo "📦 创建虚拟环境..."
    python3 -m venv venv_proxy
fi

# 激活虚拟环境
echo "🔧 激活虚拟环境..."
source venv_proxy/bin/activate

# 安装依赖
echo "📥 安装依赖..."
pip install -r requirements_proxy.txt

# 启动服务器
echo "🌐 启动代理服务器..."
echo "📝 请访问: http://localhost:5000/account.html"
echo "⏹️  按 Ctrl+C 停止服务器"
echo ""

python3 proxy_server.py
