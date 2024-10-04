# 時系列データの操作

## テーブルの作成

時系列データを格納するためのテーブルを作成する例です。

```sql
CREATE TABLE metrics (
    time TIMESTAMP PRIMARY KEY,
    value NUMERIC
);
```

## 時系列データの挿入

```sql
INSERT INTO metrics (time, value) VALUES
('2023-01-01 00:00:00', 100),
('2023-01-01 01:00:00', 200);
```

## 時系列データの集計

集計関数を用いてデータを時系列で集計する例です。

```sql
SELECT DATE_TRUNC('hour', time) as hour, AVG(value)
FROM metrics
GROUP BY DATE_TRUNC('hour', time)
ORDER BY hour;
```
