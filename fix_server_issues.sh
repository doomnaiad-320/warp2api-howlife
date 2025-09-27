#!/bin/bash

# 修复服务器部署问题的脚本

echo "🔧 修复账号管理器服务器问题"
echo "================================"

# 1. 创建缺失的requirements_proxy.txt
echo "📝 创建/更新 requirements_proxy.txt..."
cat > requirements_proxy.txt << 'EOF'
flask>=2.0.0
flask-cors>=3.0.0
requests>=2.25.0
EOF

# 2. 停止现有服务
echo "🛑 停止现有服务..."
pkill -f proxy_server.py 2>/dev/null || true
sleep 2

# 3. 安装依赖
echo "📥 安装依赖..."
pip3 install --user flask flask-cors requests

# 4. 检查必要文件
echo "📋 检查必要文件..."
if [ ! -f "proxy_server.py" ]; then
    echo "❌ 错误: proxy_server.py 文件不存在"
    exit 1
fi

if [ ! -f "account.html" ]; then
    echo "❌ 错误: account.html 文件不存在"
    exit 1
fi

# 5. 创建日志目录
mkdir -p logs

# 6. 检查端口
PORT=8021
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "⚠️  端口 $PORT 被占用，正在释放..."
    PID=$(lsof -ti:$PORT)
    kill -9 $PID 2>/dev/null || true
    sleep 1
fi

# 7. 启动服务
echo "🚀 启动账号管理器..."
echo "📝 访问地址: http://$(hostname -I | awk '{print $1}'):8021/account.html"
echo "🔧 本地访问: http://localhost:8021/account.html"
echo ""

# 后台启动
nohup python3 proxy_server.py > logs/account-manager.log 2>&1 &
PID=$!

# 等待服务启动
sleep 3

# 检查服务是否启动成功
if kill -0 $PID 2>/dev/null; then
    echo "✅ 服务启动成功！PID: $PID"
    echo "📊 查看日志: tail -f logs/account-manager.log"
    echo "🛑 停止服务: kill $PID"
    
    # 测试服务
    echo "🧪 测试服务..."
    if curl -s http://localhost:8021/ > /dev/null; then
        echo "✅ 服务响应正常"
    else
        echo "⚠️  服务可能未完全启动，请稍等片刻"
    fi
else
    echo "❌ 服务启动失败，请检查日志: cat logs/account-manager.log"
    exit 1
fi

echo ""
echo "🎉 修复完成！"
echo "现在可以通过浏览器访问账号管理器了"
