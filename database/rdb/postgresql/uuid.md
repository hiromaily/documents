# PostgreSQLの UUID型

[UUID Functions](https://www.postgresql.org/docs/current/functions-uuid.html)

この実体は、`version 4 (random) UUID`でパフォーマンス的によくない

- [PostgreSQL and UUID as primary key](https://maciejwalkowiak.com/blog/postgres-uuid-primary-key/)
  - ランダムな UUID は、B-Tree インデックスには適していない
  - B-tree インデックスは、自動インクリメントされたカラムや時間順にソートされたカラムなど、順序付けられた値で最もよく機能する
  - v7 を使うことでパフォーマンスの向上が望める
