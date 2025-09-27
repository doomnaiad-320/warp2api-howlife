#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
简单的代理服务器，用于解决 CORS 问题
"""

from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import requests
import os
import sqlite3
import json
from datetime import datetime

app = Flask(__name__)
# 配置CORS，允许所有来源的跨域请求
CORS(app, resources={
    r"/*": {
        "origins": "*",
        "methods": ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
        "allow_headers": ["Content-Type", "Authorization", "X-Requested-With"]
    }
})

@app.route('/')
def index():
    """返回 account.html 页面"""
    return send_from_directory('.', 'account.html')

@app.route('/proxy/warp-token', methods=['POST', 'OPTIONS'])
def proxy_warp_token():
    # 处理预检请求
    if request.method == 'OPTIONS':
        response = app.make_default_options_response()
        headers = response.headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'Content-Type'
        return response
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

@app.route('/api/test-database', methods=['POST'])
def test_database():
    """测试数据库连接"""
    try:
        data = request.get_json()
        db_path = data.get('db_path')

        if not db_path:
            return jsonify({'success': False, 'error': '数据库路径不能为空'})

        # 检查文件是否存在
        if not os.path.exists(db_path):
            return jsonify({'success': False, 'error': f'数据库文件不存在: {db_path}'})

        # 尝试连接数据库
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()

        # 检查accounts表是否存在
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='accounts'")
        table_exists = cursor.fetchone()

        if not table_exists:
            conn.close()
            return jsonify({'success': False, 'error': 'accounts表不存在'})

        # 获取表结构信息
        cursor.execute("PRAGMA table_info(accounts)")
        columns = cursor.fetchall()
        column_names = [col[1] for col in columns]

        conn.close()

        return jsonify({
            'success': True,
            'table_info': f'包含字段: {", ".join(column_names)}'
        })

    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/import-account', methods=['POST'])
def import_account():
    """导入单个账号到数据库"""
    try:
        data = request.get_json()
        db_path = data.get('db_path')
        account = data.get('account')

        if not db_path or not account:
            return jsonify({'success': False, 'error': '缺少必要参数'})

        # 检查数据库文件
        if not os.path.exists(db_path):
            return jsonify({'success': False, 'error': f'数据库文件不存在: {db_path}'})

        # 连接数据库
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()

        # 检查邮箱是否已存在
        cursor.execute("SELECT email FROM accounts WHERE email = ?", (account['email'],))
        existing = cursor.fetchone()

        if existing:
            conn.close()
            return jsonify({'success': False, 'error': '邮箱已存在'})

        # 插入账号数据 - 使用SQLite的datetime('now')函数
        insert_sql = """
        INSERT INTO accounts (email, local_id, id_token, refresh_token, status, created_at)
        VALUES (?, ?, ?, ?, ?, datetime('now'))
        """

        cursor.execute(insert_sql, (
            account['email'],
            account['local_id'],
            account['id_token'],
            account['refresh_token'],
            account['status']
        ))

        conn.commit()
        conn.close()

        return jsonify({'success': True, 'message': '账号导入成功'})

    except sqlite3.IntegrityError as e:
        return jsonify({'success': False, 'error': f'数据完整性错误: {str(e)}'})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/<path:filename>')
def serve_static(filename):
    """提供静态文件"""
    return send_from_directory('.', filename)

if __name__ == '__main__':
    print("🚀 启动代理服务器...")
    print("📝 访问: http://localhost:8021/account.html")
    print("🔧 代理端点: http://localhost:8021/proxy/warp-token")
    app.run(host='0.0.0.0', port=8021, debug=True)
