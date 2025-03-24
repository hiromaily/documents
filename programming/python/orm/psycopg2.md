# [Psycopg 2](https://www.psycopg.org/docs/)

Psycopg 2は、Pythonプログラミング言語からPostgreSQLデータベースサーバーに接続するためのアダプター。これは非常に人気が高く、高性能で安定しており、多くのプロジェクトで広く使用されている。

1. **対応データベース**:
   - PostgreSQLに特化しているため、PostgreSQLの機能を最大限に活用可能。

2. **パフォーマンス**:
   - Cで書かれているため、非常に高速で、特に大量のデータを扱う場合に高いパフォーマンスを発揮。

3. **トランザクション管理**:
   - トランザクションを自動的に管理し、簡単にBEGIN、COMMIT、ROLLBACKが可能。

4. **スレッドセーフ**:
   - マルチスレッド環境でも安全に使用できるように設計。

5. **拡張機能**:
   - PostgreSQLの固有機能（COPY、LISTEN/NOTIFY、hstore、JSONBなど）をサポート。

## インストール

```sh
pip install psycopg2
　or
# バイナリパッケージとしてインストール
pip install psycopg2-binary
```

## データベース接続の設定

Psycopg 2を使ってPostgreSQLデータベースに接続します。

```python
import psycopg2

# データベースに接続
conn = psycopg2.connect(
    dbname="yourdbname", 
    user="yourusername", 
    password="yourpassword", 
    host="yourdbhost", 
    port="yourdbport"
)
```

## クエリの実行

カーソルを使ってデータベース操作を行います。

```python
# カーソルを作成
cur = conn.cursor()

# テーブルの作成
cur.execute("""
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100),
        age INTEGER
    )
""")

# データの挿入
cur.execute("INSERT INTO users (name, age) VALUES (%s, %s)", ("Alice", 30))

# データのクエリ
cur.execute("SELECT id, name, age FROM users WHERE name = %s", ("Alice",))
rows = cur.fetchall()
for row in rows:
    print(f"id: {row[0]}, name: {row[1]}, age: {row[2]}")

# トランザクションをコミット
conn.commit()

# カーソルと接続を閉じる
cur.close()
conn.close()
```

## エラーハンドリング

Psycopg 2では、エラーハンドリングが重要です。以下は基本的なエラーハンドリングの例です。

```python
import psycopg2
from psycopg2 import sql, Error

try:
    conn = psycopg2.connect("dbname=test user=postgres password=secret")
    cur = conn.cursor()
    cur.execute("SELECT * FROM non_existent_table")
except (Exception, psycopg2.DatabaseError) as error:
    print(f"Error: {error}")
finally:
    if conn is not None:
        conn.close()
```
