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
