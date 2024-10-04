# 拡張 (Extensions)

[ReadLater]

PostgreSQL は様々な拡張機能が提供されており、それらを使用して標準機能を拡張することができる

## 拡張のインストール

PostgreSQL に拡張をインストールする例

```sql
-- 例: PostGIS (地理空間データベース)
CREATE EXTENSION postgis;
```

## 使用可能な拡張の一覧表示

```sql
-- 使用可能な拡張のリストを表示
SELECT * FROM pg_available_extensions;
```

## よく利用されている Extensions

### 1. PostGIS

**説明**: 地理空間データの格納、解析、および操作を行うための拡張機能。GIS データを扱うには不可欠。

```sql
CREATE EXTENSION postgis;
```

### 2. pg_stat_statements

**説明**: データベースで実行された全ての SQL ステートメントの統計情報を収集する拡張機能。クエリのパフォーマンスチューニングに役立つ。

```sql
CREATE EXTENSION pg_stat_statements;
```

**使用例**:

```sql
SELECT * FROM pg_stat_statements ORDER BY total_time DESC LIMIT 10;
```

### 3. hstore

**説明**: キー/バリューペアを格納するためのデータ型を提供する拡張機能。スキーマの自由度が高いデータを扱う場合に便利。

```sql
CREATE EXTENSION hstore;
```

**使用例**:

```sql
-- テーブルの作成
CREATE TABLE example (data hstore);

-- データの挿入
INSERT INTO example VALUES ('key1 => value1, key2 => value2');
```

### 4. citext

**説明**: 大文字小文字を区別しないテキストデータ型を提供する拡張機能。ユーザー名やメールアドレスなど大文字小文字を意識したくないデータに役立つ。

```sql
CREATE EXTENSION citext;
```

**使用例**:

```sql
-- テーブルの作成
CREATE TABLE users (email CITEXT);

-- データの挿入
INSERT INTO users VALUES ('User@example.com');

-- 大文字小文字を区別しない検索
SELECT * FROM users WHERE email = 'user@example.com';
```

### 5. pg_trgm

**説明**: テキストの類似度検索を行うためのトリグラム（3-gram）マッチングをサポートする拡張機能。部分一致やファジーマッチ検索に利用される。

```sql
CREATE EXTENSION pg_trgm;
```

**使用例**:

```sql
-- 類似度を計算する
SELECT similarity('hello', 'hallo');
```

### 6. cube

**説明**: 多次元データを扱うためのデータ型と関数群を提供する拡張機能。多次元座標データやカスタム KNN 検索で利用される。

```sql
CREATE EXTENSION cube;
```

**使用例**:

```sql
-- テーブルの作成
CREATE TABLE multidimensional_data (id SERIAL PRIMARY KEY, data CUBE);

-- データの挿入
INSERT INTO multidimensional_data (data) VALUES (CUBE(1, 2, 3));
```

### 7. intarray

**説明**: 整数配列データ型用の一連の関数と演算子を提供する拡張機能。整数配列の簡単な操作が可能になる。

```sql
CREATE EXTENSION intarray;
```

**使用例**:

```sql
-- 配列のソート
SELECT sort(ARRAY[3, 1, 2]);
```

### 8. fuzzystrmatch

**説明**: テキストの曖昧一致を行うための関数（Soundex や Levenshtein 距離）を提供する拡張機能。ファジーマッチ検索やテキスト正規化に利用される。

```sql
CREATE EXTENSION fuzzystrmatch;
```

**使用例**:

```sql
-- Soundexの計算
SELECT soundex('hello');

-- Levenshtein距離の計算
SELECT levenshtein('kitten', 'sitting');
```

### 9. btree_gin

**説明**: `GIN`（Generalized Inverted Index）インデックスを作成するための演算子を拡張。複数カラムのインデックスを効率的に作成・利用できる。

```sql
CREATE EXTENSION btree_gin;
```

**使用例**:

```sql
-- 複数カラムのGINインデックスを作成する
CREATE INDEX idx_name ON users USING GIN (lastname gin_trgm_ops, firstname gin_trgm_ops);
```

### 10. unaccent

**説明**: テキストからアクセントやダイアクリティカルマーク（アクセント記号）を除去するための関数を提供する拡張機能。インデックス検索をより効果的に行うために使用される。

```sql
CREATE EXTENSION unaccent;
```

**使用例**:

```sql
-- アクセントの除去
SELECT unaccent('école') = 'ecole';
```

### 11. uuid-ossp

**説明**: UUID を生成するための関数を提供する拡張機能。グローバルにユニークな ID が必要な場合に利用される。

```sql
CREATE EXTENSION "uuid-ossp";
```

**使用例**:

```sql
-- UUIDの生成
SELECT uuid_generate_v4();
```

### 12. tablefunc

**説明**: クロス集計（クロス集計テーブル）や他の特殊なテーブル操作を行うための関数を提供する拡張機能。

```sql
CREATE EXTENSION tablefunc;
```

**使用例**:

```sql
-- クロス集計 (pivot table)
SELECT * FROM crosstab(
  'SELECT rowid, attribute, value FROM my_table ORDER BY 1,2'
) AS ct(rowid int, attribute1 text, attribute2 text);
```

### 13. plpgsql

**説明**: PostgreSQL の組み込み手続き言語である PL/pgSQL を有効にする拡張機能。関数やトリガを定義する際に使用される。

```sql
-- PostgreSQL のバージョンによっては既にインストール済み
CREATE EXTENSION plpgsql;
```

**使用例**:

```sql
-- PL/pgSQL関数の作成
CREATE OR REPLACE FUNCTION increment_by_one(n INT) RETURNS INT AS $$
BEGIN
  RETURN n + 1;
END;
$$ LANGUAGE plpgsql;
```
