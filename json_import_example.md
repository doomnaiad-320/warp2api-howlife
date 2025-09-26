# JSON批量导入功能使用说明

## 🎯 功能概述

新增的JSON批量导入功能允许你通过粘贴JSON数据快速添加多个账号到表单中，支持分次添加，无需手动逐个输入。

## 📝 支持的JSON格式

### 单个账号对象
```json
{
  "id": 892,
  "uid": "8nqahpKe8aTtZJStJjHR5Em0qQ92",
  "email": "579b6481@ddmi888.net",
  "type": "PRO_TRIAL",
  "quota": 2500,
  "used": 0,
  "desc": "9月26",
  "nextRefreshTime": "27/10/2025 21:26:03",
  "periodEndTime": "10/10/2025 21:26:05",
  "refreshToken": "AMf-vByUVn2D6MYPihHeGbMCdpaWYZgr_7XsJhLHAkVcyJ2YigFudkqvgWWufav29GjvkcLSTMstgXbr6AQMHy9DkPpqiiRZSRL1GhWsPzs9Z9l5MQSKWvZTPb1K_LrYyF8A-VW-MsdHDlUDnYOWF-406eYiT7sH0ozyWDEhwatmRHab4GDDQMwmUhOcyAHngX6aK_V_9EzrubeCol_BB1CSEeZo3zv8sw",
  "createdAt": "26/9/2025 21:26:05"
}
```

### 多个账号数组
```json
[
  {
    "uid": "8nqahpKe8aTtZJStJjHR5Em0qQ92",
    "email": "579b6481@ddmi888.net",
    "refreshToken": "AMf-vByUVn2D6MYPihHeGbMCdpaWYZgr_7XsJhLHAkVc..."
  },
  {
    "uid": "9mqbhqLf9bUuaKTuKkIS6Fn1rR03",
    "email": "680c7592@ddmi888.net",
    "refreshToken": "AMf-vBzVWo3E7NZQjkIfHcNDerqbXahgs_8YtKiMBlWd..."
  }
]
```

### 简化格式（只包含必要字段）
```json
{
  "uid": "8nqahpKe8aTtZJStJjHR5Em0qQ92",
  "email": "579b6481@ddmi888.net", 
  "refreshToken": "AMf-vByUVn2D6MYPihHeGbMCdpaWYZgr_7XsJhLHAkVc..."
}
```

## 🔧 字段映射

系统会自动提取以下字段：

| 目标字段 | 支持的JSON字段名 |
|---------|-----------------|
| Firebase UID | `uid`, `local_id`, `firebase_uid` |
| 邮箱地址 | `email` |
| Refresh Token | `refreshToken`, `refresh_token` |

## 📋 使用步骤

1. **访问页面**: 打开 http://localhost:8021/account.html
2. **找到导入区域**: 页面中的"📥 JSON批量导入"部分
3. **粘贴JSON数据**: 将你的JSON数据粘贴到文本框中
4. **点击解析**: 点击"📥 解析并添加到表单"按钮
5. **查看结果**: 系统会显示成功/失败的统计信息
6. **处理账号**: 添加到表单后，点击"🚀 开始处理"获取tokens

## ✨ 功能特点

- **智能解析**: 自动识别单个对象或数组格式
- **字段兼容**: 支持多种字段名称变体
- **分次添加**: 可以多次使用，逐步添加账号
- **错误处理**: 详细的错误信息和成功统计
- **数据验证**: 确保必要字段完整性

## 🚨 注意事项

1. **必要字段**: uid、email、refreshToken 三个字段必须存在
2. **JSON格式**: 确保JSON格式正确，否则解析会失败
3. **分次添加**: 每次导入会添加到现有表单中，不会清空已有数据
4. **数据安全**: refreshToken是敏感信息，请确保在安全环境中使用

## 🔄 工作流程

```
JSON数据输入 → 格式验证 → 字段提取 → 添加到表单 → 手动处理 → 生成SQLite/CSV
```

## 📊 示例操作

假设你有以下JSON数据：
```json
{
  "uid": "test123",
  "email": "test@example.com",
  "refreshToken": "AMf-vBy..."
}
```

操作步骤：
1. 复制上述JSON
2. 粘贴到"JSON数据"文本框
3. 点击"📥 解析并添加到表单"
4. 系统显示"✅ 成功添加 1 个账号到表单"
5. 在表单中看到新增的账号条目
6. 点击"🚀 开始处理"获取完整的token信息

这样就完成了从JSON到SQLite命令的完整流程！
