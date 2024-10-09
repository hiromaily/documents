# [TIMESTAMP および DATETIME の自動初期化および更新機能](https://dev.mysql.com/doc/refman/8.0/ja/timestamp-initialization.html)

MySQLで行が更新されるたびに `updated_at` 列に現在時刻を自動的に設定するには、以下のような方法を取ることが一般的

## テーブル作成例

```sql
CREATE TABLE my_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

この例では、`created_at` 列に行が挿入された時のタイムスタンプが、自動的に設定される。`updated_at` 列は行が更新されるたびに自動的に現在時刻に更新される。この方法は時刻を更新するためのトリガーを使わない方法での最も簡単な設定方法の一つ。
