# 服务器部署指南

## 🚀 快速部署到服务器

### 1. 上传文件到服务器

将以下文件上传到服务器：
```bash
# 必需文件
proxy_server.py
account.html
deploy_account_manager.sh

# 可选文件（会自动创建）
requirements_proxy.txt
```

### 2. 一键部署

```bash
# 给脚本执行权限
chmod +x deploy_account_manager.sh

# 前台运行（用于测试）
./deploy_account_manager.sh

# 后台运行（生产环境）
./deploy_account_manager.sh --daemon
```

### 3. 访问服务

```bash
# 本地访问
http://localhost:8021/account.html

# 服务器IP访问
http://YOUR_SERVER_IP:8021/account.html
```

## 🔧 手动部署步骤

如果自动部署脚本有问题，可以手动执行：

### 1. 安装依赖
```bash
pip3 install --user flask flask-cors requests
```

### 2. 启动服务
```bash
python3 proxy_server.py
```

### 3. 检查服务状态
```bash
# 检查端口是否监听
netstat -tlnp | grep 8021

# 检查进程
ps aux | grep proxy_server
```

## 🐛 故障排除

### 问题1: CORS错误
**现象**: 浏览器控制台显示CORS错误
**解决**: 
- 确保通过服务器IP:8021访问，不要直接打开HTML文件
- 检查代理服务器是否正常运行

### 问题2: 端口被占用
**现象**: `Address already in use`
**解决**:
```bash
# 查找占用端口的进程
lsof -i :8021

# 停止进程
kill -9 PID
```

### 问题3: 依赖安装失败
**现象**: `ModuleNotFoundError`
**解决**:
```bash
# 更新pip
pip3 install --upgrade pip

# 重新安装依赖
pip3 install --user flask flask-cors requests
```

### 问题4: 权限问题
**现象**: `Permission denied`
**解决**:
```bash
# 给脚本执行权限
chmod +x deploy_account_manager.sh

# 检查文件权限
ls -la proxy_server.py account.html
```

## 🔒 安全配置

### 1. 防火墙设置
```bash
# Ubuntu/Debian
sudo ufw allow 8021

# CentOS/RHEL
sudo firewall-cmd --permanent --add-port=8021/tcp
sudo firewall-cmd --reload
```

### 2. 反向代理（可选）
如果需要通过域名访问，可以配置Nginx：

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:8021;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## 📊 监控和日志

### 查看日志
```bash
# 实时查看日志
tail -f logs/account-manager.log

# 查看错误日志
grep -i error logs/account-manager.log
```

### 服务状态检查
```bash
# 健康检查
curl http://localhost:8021/

# 检查代理端点
curl -X POST http://localhost:8021/proxy/warp-token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=refresh_token&refresh_token=test"
```

## 🔄 服务管理

### 启动服务
```bash
./deploy_account_manager.sh --daemon
```

### 停止服务
```bash
# 查找进程ID
ps aux | grep proxy_server

# 停止服务
kill PID
```

### 重启服务
```bash
# 停止现有服务
pkill -f proxy_server.py

# 重新启动
./deploy_account_manager.sh --daemon
```

## 📝 使用说明

1. **访问页面**: 通过浏览器访问 `http://服务器IP:8021/account.html`
2. **添加账号**: 
   - 手动输入：填写表单字段
   - JSON导入：粘贴JSON数据批量添加
3. **处理账号**: 点击"开始处理"获取tokens
4. **导出数据**: 复制生成的SQLite命令或CSV数据

## ⚠️ 注意事项

1. **端口开放**: 确保服务器防火墙开放8021端口
2. **网络访问**: 服务器需要能访问 `app.warp.dev`
3. **数据安全**: refresh_token是敏感信息，请在安全环境中使用
4. **资源限制**: 注意服务器的CPU和内存使用情况

## 🆘 紧急恢复

如果服务出现问题，可以快速重置：

```bash
# 停止所有相关进程
pkill -f proxy_server

# 清理日志
rm -f logs/account-manager.log

# 重新部署
./deploy_account_manager.sh --daemon
```
