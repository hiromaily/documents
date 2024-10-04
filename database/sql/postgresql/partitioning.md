# パーティショニング

大きなテーブルを複数の小さなテーブルに分割することで、クエリのパフォーマンスを向上させることができる

```sql
-- パーティション付きテーブルの作成
CREATE TABLE measurement (
    city_id INT,
    logdate DATE,
    peaktemp INT,
    unitsales INT
) PARTITION BY RANGE (logdate);
```
