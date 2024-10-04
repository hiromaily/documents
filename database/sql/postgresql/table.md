# テーブル操作

## テーブルの作成

新しいテーブルを作成するための SQL 文

```sql
CREATE TABLE mytable (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## テーブルの削除

既存のテーブルを削除するための SQL 文

```sql
DROP TABLE mytable;
```

## テーブルの構造を変更

テーブルに新しいカラムを追加するための SQL 文

```sql
ALTER TABLE mytable ADD COLUMN email VARCHAR(255);
```

## インデックスの作成

クエリのパフォーマンスを向上させるためにインデックスを作成する例

```sql
CREATE INDEX idx_name ON employees(name);
```

## テーブルのトランケート

指定されたテーブルの全てのデータを高速に削除するためのコマンド

```sql
TRUNCATE TABLE mytable;

-- 複数テーブル
TRUNCATE TABLE table1, table2;
```

### TRUNCATE の特徴

1. **高速**:
   `TRUNCATE`はテーブルの全ての行を削除するため、`DELETE`と比較して非常に高速。テーブル全体を一括で操作するため、行ごとに削除処理を行う`DELETE`コマンドよりも効率的。

2. **トランザクションブロックでの使用可能**:
   `TRUNCATE`コマンドはトランザクションブロック内でも使用できる。トランザクションの途中でトランケートされたテーブルも、他のトランザクションが終わるまではその影響を受けない。

3. **自動コミット**:
   `DELETE`コマンドと違い、`TRUNCATE`は自動的にコミットされるため、`TRUNCATE`の実行後にロールバックはできない。ただし、トランザクションブロック内で使用するとその制約は緩和される。

4. **再起動シーケンスのリセット**:
   `TRUNCATE`はテーブルのシステムカラム（例えば、`SERIAL`や`BIGSERIAL`のカラム）もリセットする。そのため、ID フィールドを持つテーブルで`TRUNCATE`を行うと、次に挿入される行の ID は再び初期値（一般に 1）となる。

   ```sql
   TRUNCATE TABLE mytable RESTART IDENTITY;
   ```

   `RESTART IDENTITY`を使用することで、ID（シーケンス）もリセットされる。

5. **カスケードのサポート**:
   `TRUNCATE`は、外部キー制約で参照されているテーブルの場合、関連するテーブルも一緒に削除する`CASCADE`オプションを提供する。

   ```sql
   TRUNCATE TABLE parent_table CASCADE;
   ```

   上記のコマンドは`parent_table`とそれに関連する全ての子テーブルのデータを削除する。

6. **トリガの無効化**:
   `TRUNCATE`は`DELETE`とは異なり、削除された行に対してトリガを発火させない。このため、トリガ処理が必要な場合には`DELETE`を使用する必要がある。
