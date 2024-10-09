# MySQL UUID 型

```sql
CREATE TABLE my_table (
  uuid VARCHAR(36) DEFAULT (UUID()) PRIMARY KEY,
  name VARCHAR(20),
  beers int unsigned
);
```

MySQL データベースの主キーとして UUID を使用することは、パフォーマンス面での欠点がある

- 挿入パフォーマンス
- より高いストレージ使用率

## MySQL で UUID 主キーを使用するベストな方法

- バイナリデータ型を使用する
  - `BINARY(16)` カラムに格納する
- 順序付けられた UUID バリアントを使う
  - バージョン`6`や`7`のような時間ベースの UUID は、値を可能な限りシーケンシャルに近づけながら一意性を保証することができる
- 組み込みの MySQL UUID 関数を使用する
  - `uuid_to_bin`というヘルパー関数を使う
- 別の ID タイプを使う
  - Snowflake ID や ULID, NanoID など

```sql
CREATE TABLE my_table2 (
  uuid BINARY(16) DEFAULT (UUID_TO_BIN(UUID(), 1)) PRIMARY KEY,
  name VARCHAR(20),
  beers int unsigned
);
```

## UUID 型 References

- [MySQL & UUIDs](https://blogs.oracle.com/mysql/post/mysql-uuids)
- [MySQL で UUIDv4 をプライマリキーにするとパフォーマンス問題が起きるのはなぜ？](https://zenn.dev/reiwatravel/articles/9ce1050bf8509b)
- [The Problem with Using a UUID Primary Key in MySQL](https://planetscale.com/blog/the-problem-with-using-a-uuid-primary-key-in-mysql)
