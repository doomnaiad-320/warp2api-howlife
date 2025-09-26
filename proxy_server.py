#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
简单的代理服务器，用于解决 CORS 问题
"""

from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import requests
import os

app = Flask(__name__)
CORS(app)  # 允许所有来源的跨域请求

@app.route('/')
def index():
    """返回 account.html 页面"""
    return send_from_directory('.', 'account.html')

@app.route('/proxy/warp-token', methods=['POST'])
def proxy_warp_token():
    """代理 Warp API 请求"""
    try:
        # 获取请求数据
        form_data = request.form.to_dict()
        
        # 构建目标 URL
        target_url = 'https://app.warp.dev/proxy/token?key=AIzaSyBdy3O3S9hrdayLJxJ7mriBR4qgUaUygAs'
        
        # 设置请求头
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36',
            'Content-Type': 'application/x-www-form-urlencoded'
        }
        
        # 发送请求到 Warp API
        response = requests.post(target_url, data=form_data, headers=headers, timeout=30)
        
        # 返回响应
        if response.status_code == 200:
            return jsonify(response.json())
        else:
            return jsonify({
                'error': f'HTTP {response.status_code}: {response.text}'
            }), response.status_code
            
    except requests.exceptions.RequestException as e:
        return jsonify({
            'error': f'请求失败: {str(e)}'
        }), 500
    except Exception as e:
        return jsonify({
            'error': f'服务器错误: {str(e)}'
        }), 500

@app.route('/<path:filename>')
def serve_static(filename):
    """提供静态文件"""
    return send_from_directory('.', filename)

if __name__ == '__main__':
    print("🚀 启动代理服务器...")
    print("📝 访问: http://localhost:8021/account.html")
    print("🔧 代理端点: http://localhost:8021/proxy/warp-token")
    app.run(host='0.0.0.0', port=8021, debug=True)
