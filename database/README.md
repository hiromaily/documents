# Database

## SQL クエリの N+1 問題

N 件のデータ行を持つテーブルをごそっと読みだすのに 1 回、
別のテーブルから、先述のテーブルの各行に紐づくデータを（1 件ずつ）読み出すのに計 N 回、
合計で N+1 回のクエリを実行している状態

### 解決方法

- JOIN 句による表の結合
- Eager Loading

```sql
SELECT * FROM parent;
SELECT * FROM child WHERE ID IN (3, 1, 2, 1, 4);
```

## DB のユニークキー

[データベースでユニークキーに UUID を使うメリットは何ですか？](https://jp.quora.com/%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9%E3%81%A7%E3%83%A6%E3%83%8B%E3%83%BC%E3%82%AF%E3%82%AD%E3%83%BC%E3%81%ABUUID%E3%82%92%E4%BD%BF%E3%81%86%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88%E3%81%AF%E4%BD%95)

`プライマリキーには原則としてデータベース側で発行される自動インクリメントの連番を使っておくのが間違いない`

## EnumがなぜAntiパターンと言われるのか？

- [SQLアンチパターン感想その二ーENUM型を扱う](https://zenn.dev/convers39/articles/0e58e17d0da43f)