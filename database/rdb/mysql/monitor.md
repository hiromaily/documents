# Monitor MySQL

Docker環境でMySQL8.0を使用している場合、大量のInsert文が実行されたときのDBサーバーの負荷を計測するための基本的な手順を以下に示します。

## 1. Docker Containerのリソース使用率の確認

Dockerが実行されているホストマシン上で、`docker stats`コマンドを使用して、各コンテナのCPU使用率、メモリ使用率、ネットワークI/O、ブロックI/Oなどをモニタリングできる。

```bash
docker stats
```

## 2. MySQLのパフォーマンスモニタリング

MySQL自体にもパフォーマンスを監視するためのツールやコマンドがある。以下の手順に従って設定とモニタリングを行う。

### InnoDBの状態を確認

InnoDBを使用している場合、以下のSQLコマンドでInnoDBのステータス情報を得ることができる。

```sql
SHOW ENGINE INNODB STATUS;
```

### Performance Schemaの有効化

MySQLには`Performance Schema`というパフォーマンスを監視するためのツールが組み込まれている。これを有効にし、必要な情報を取得。

1. `Performance Schema`の有効化と設定を確認：

    ```sql
    SHOW VARIABLES LIKE 'performance_schema';
    SET GLOBAL performance_schema = 1;
    ```

2. パフォーマンスを示すテーブルのクエリ：

    ```sql
    SELECT * FROM performance_schema.events_statements_summary_by_digest ORDER BY SUM_TIMER_WAIT DESC LIMIT 10;
    ```

### EXPLAINを使用してクエリのパフォーマンスを分析

個々のクエリのパフォーマンスを分析するのに`EXPLAIN`コマンドが有用。たとえば、特定のINSERT文がどのように実行されるかを確認できる。

```sql
EXPLAIN INSERT INTO your_table (col1, col2, ...) VALUES (...);
```

## 3. ホストシステムのモニタリングツールの活用

Dockerコンテナが稼働しているホストシステムでもリソースの使用状況をモニタリングすることが重要。以下のツールが使用できる：

- `top` または `htop` ： CPU使用率、メモリ使用率などのリソース使用状況をリアルタイムで確認。
- `iostat` ： I/Oサブシステムのモニタリング。
- `vmstat` ： システム全体のパフォーマンスを簡単に把握。

## 4. ログの確認

MySQLのエラーログやクエリログを確認して異常な点がないか、ボトルネックになっている部分がないかを確認する。ログの場所は通常`my.cnf`ファイル（設定ファイル）に記載されている。

```bash
# エラーログの確認（例）
tail -f /var/log/mysql/error.log
```
