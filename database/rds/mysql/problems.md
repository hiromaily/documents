# MySQLで起きた Problems

## MySQL 接続時 `Public Key Retrieval is not allowed` エラー

ドライバの設定で、以下を修正する

```conf
allowPublicKeyRetrieval=true
```
