# トリガ

## トリガの作成

特定のイベントが発生したときに自動的に実行されるトリガを作成する例です。

```sql
-- トリガ用の関数を作成
CREATE FUNCTION log_update() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_table (changed_at, old_data, new_data)
    VALUES (CURRENT_TIMESTAMP, OLD.*, NEW.*);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- トリガを設定
CREATE TRIGGER log_update_trigger
AFTER UPDATE ON mytable
FOR EACH ROW EXECUTE FUNCTION log_update();
```
