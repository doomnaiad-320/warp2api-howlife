### 获取账号信息接口
``` curl --location --request POST 'https://app.warp.dev/proxy/token?key=AIzaSyBdy3O3S9hrdayLJxJ7mriBR4qgUaUygAs' \
--header 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=refresh_token' \
--data-urlencode 'refresh_token=AMf-vBxfdoz_SpGL7iL_hmShwAsIp_OdU4EAcX7rGC6TfyU37sr9zFhhfMjqhMoM3ZYZl-tkP2Cs0FGWHai9SGro1yHdAxfnepl_tRawzUBlCTWsjRVuEA6b_PUkIx31gwuKXjriOVPOJWkzg3oCw29UECYtj7Hfr2FS6X_lrznLCHKWjyGGHGZdRkWPnV4WsbfZNFY0Hy2EI1bzVQdrtbXAD5c7vf6onz10rrPZ5Kf6tTI1RlMGR_o'
```

### 获取账号信息接口返回样式
```
{
  "access_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6ImVmMjQ4ZjQyZjc0YWUwZjk0OTIwYWY5YTlhMDEzMTdlZjJkMzVmZTEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYXN0cmFsLWZpZWxkLTI5NDYyMSIsImF1ZCI6ImFzdHJhbC1maWVsZC0yOTQ2MjEiLCJhdXRoX3RpbWUiOjE3NTY2MzI1NDYsInVzZXJfaWQiOiJNU0VYODFLVFBtWUNGa0huZEMwUkU3ajh4blUyIiwic3ViIjoiTVNFWDgxS1RQbVlDRmtIbmRDMFJFN2o4eG5VMiIsImlhdCI6MTc1NjY5MTg1NSwiZXhwIjoxNzU2Njk1NDU1LCJlbWFpbCI6IjEzNzk2MDUzMjNAcXEuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiMTM3OTYwNTMyM0BxcS5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.hT8vzO7B8vD4o9oUIi2yqG43_VM8NpLH2JId4Yh25ZX-vi8r-4OycWr8QZPBoqGIhW3NJgI5qFQmyYhsAIt7qGJPqbqLdHt6Xca3S5Pf9EoBLg2aZyFfEP-BSZkbfDQ1zyHlQ4JYQC-lnTIMMfFUAfNm364wJvX-IFLzYJZ7SnkreCXfgi_wKPQhTtuzwU4M5dkXRWPDPyh4zIBdhzv5FsimuJYXxFnenDQmZJWPG932SZpPlUZDLh_ekA7jp8lUhrcV0Duw5e6TbCVSdYgFwVKi5RpgfrQ1JNiV7abpFrdPqu1qgfxGh8ye9nYC3DPrP9X65DLWqhPysjq1RLQqYA",
  "expires_in": "3600",
  "token_type": "Bearer",
  "refresh_token": "AMf-vBy40B-X0e74OXaCrWc5shrpdgv8R-aSCQE-QdgBWZyJdgG27E7DY2ScW095AzaguPq0lIL5H8tGArBVwMyFD-7bypx8Y7HWvoqGB2-KnU6z_CvyCy0xusYnZKc07QaHN1uRYSjUA6VuV4nG4rzuchNPyyTHnjSjtKMgy6sfuLdB-pv-meCS4z1pOV1r5asjw2yH6nTb89XZ2Xw7sM3kp5YnrtcEZA",
  "id_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6ImVmMjQ4ZjQyZjc0YWUwZjk0OTIwYWY5YTlhMDEzMTdlZjJkMzVmZTEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYXN0cmFsLWZpZWxkLTI5NDYyMSIsImF1ZCI6ImFzdHJhbC1maWVsZC0yOTQ2MjEiLCJhdXRoX3RpbWUiOjE3NTY2MzI1NDYsInVzZXJfaWQiOiJNU0VYODFLVFBtWUNGa0huZEMwUkU3ajh4blUyIiwic3ViIjoiTVNFWDgxS1RQbVlDRmtIbmRDMFJFN2o4eG5VMiIsImlhdCI6MTc1NjY5MTg1NSwiZXhwIjoxNzU2Njk1NDU1LCJlbWFpbCI6IjEzNzk2MDUzMjNAcXEuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiMTM3OTYwNTMyM0BxcS5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.hT8vzO7B8vD4o9oUIi2yqG43_VM8NpLH2JId4Yh25ZX-vi8r-4OycWr8QZPBoqGIhW3NJgI5qFQmyYhsAIt7qGJPqbqLdHt6Xca3S5Pf9EoBLg2aZyFfEP-BSZkbfDQ1zyHlQ4JYQC-lnTIMMfFUAfNm364wJvX-IFLzYJZ7SnkreCXfgi_wKPQhTtuzwU4M5dkXRWPDPyh4zIBdhzv5FsimuJYXxFnenDQmZJWPG932SZpPlUZDLh_ekA7jp8lUhrcV0Duw5e6TbCVSdYgFwVKi5RpgfrQ1JNiV7abpFrdPqu1qgfxGh8ye9nYC3DPrP9X65DLWqhPysjq1RLQqYA",
  "user_id": "MSEX81KTPmYCFkHndC0RE7j8xnU2",
  "project_id": "13153726198"
}
```

### SQLlite命令样式

```
sqlite3 account-pool-service/accounts.db "  
INSERT INTO accounts (email, local_id, id_token, refresh_token, status, created_at)   
VALUES   
  ('account1@example.com', 'firebase_uid_1', 'id_token_1', 'refresh_token_1', 'available', datetime('now')),  
  ('account2@example.com', 'firebase_uid_2', 'id_token_2', 'refresh_token_2', 'available', datetime('now')),  
  ('account3@example.com', 'firebase_uid_3', 'id_token_3', 'refresh_token_3', 'available', datetime('now'));  
"
```

### CSV文档
#### CSV文件格式样式
根据数据库表结构，你需要创建包含以下字段的CSV文件： database.py:20-33

#### 标准CSV格式示例
```  
    email,local_id,id_token,refresh_token,status  
    user1@example.com,firebase_uid_12345,eyJhbGciOiJSUzI1NiIsImtpZCI6IjE2...,1//04_refresh_token_abc123,available  
    user2@example.com,firebase_uid_67890,eyJhbGciOiJSUzI1NiIsImtpZCI6IjE2...,1//04_refresh_token_def456,available  
    user3@example.com,firebase_uid_11111,eyJhbGciOiJSUzI1NiIsImtpZCI6IjE2...,1//04_refresh_token_ghi789,available
```
* 字段说明
```
email: 唯一的邮箱地址
local_id: Firebase用户ID/Warp UID
id_token: Firebase ID令牌（JWT格式）
refresh_token: Firebase刷新令牌
status: 账号状态，新账号使用 available
```
* csv命令
```
创建CSV文件的命令
# 创建CSV文件头部  
echo "email,local_id,id_token,refresh_token,status" > accounts.csv  
  
# 添加账号数据  
echo "user1@example.com,firebase_uid_12345,your_id_token_1,your_refresh_token_1,available" >> accounts.csv  
echo "user2@example.com,firebase_uid_67890,your_id_token_2,your_refresh_token_2,available" >> accounts.csv
echo "user3@example.com,firebase_uid_11111,your_id_token_3,your_refresh_token_3,available" >> accounts.csv
```

### 需求

1. 制作一个独立的页面.,让我手动输入框输入refresh_token.email firebase_uid id_token 这些数据你需要可以读取
2. 当我点击开始的时候.你需要携带着refresh_token 使用接口去获取.id_token 
3. 当获取到id_token 那么就要组成 'account1@example.com', 'firebase_uid_1', 'id_token_1', 'refresh_token_1', 'available 数据格式. 他们之间需要相互对应起来.不要发生混淆.Id_token要与refresh_token对应.
4. 生成 SQLite命令样式.展示给我.并能让我复制.或者你可以生成csv
