# バイナリデータの格納

標準SQLは、`BLOB`または`BINARY LARGE OBJECT`という、バイナリ列型を定義するが、PostgreSQLでは異なる。
MySQLの場合、`BLOB`型が存在する。

## データベースにバイナリとして画像を保存するメリット・デメリット

### メリット

- データの一貫性が保たれ、データベースのバックアップや復元が容易になる
- セキュリティの観点からもアクセス制御が容易になる
- トランザクション分離の問題が解決される


### デメリット

- データベースのサイズが大きくなり、パフォーマンスが低下する可能性がある
- 画像処理などの専門的な操作が難しくなる
- 画像の更新や変更が頻繁に行われる場合、データベースの負荷が増大する

- [You shouldn’t store your images/videos in a database](https://medium.com/ensias-it/you-shouldnt-store-your-images-videos-in-a-database-6a78ffa277b2)

## SQL Antipatterns: Phantom Files

ファイルのバイナリ情報をDBの内部に保存するのではなく、外部のファイルに置くというパターンこそがアンチパターンであり、データベースで画像を保存するべきという主張だが、ここで最も大切なことは「盲目的にアンチパターンを避けない」ということ

扱うファイルの数やサイズが小規模なものであれば、DBのトランザクションを利用して処理した方が、信頼性が高く実装コストも低くなることが期待できる。

## PostgreSQL

[PostgreSQL16: バイナリ列データ型](https://www.postgresql.jp/document/16/html/datatype-binary.html)

- `bytea`データ型はバイナリ列の保存を可能にする
- bytea型は入出力用に2つの書式をサポート
  - hex書式 (Default)
  - エスケープ書式

### Create文

```sql
CREATE TABLE image_box (id INTEGER PRIMARY KEY, dat BYTEA);
```

### 汎用ファイルアクセス関数

- `pg_read_binary_file`関数
  - ファイルの内容(bytea型)を返す

### バイナリデータの出力

```sql
COPY (SELECT dat FROM image_box WHERE id = 1) TO '/tmp/output_image.jpg' WITH (FORMAT binary);
```
