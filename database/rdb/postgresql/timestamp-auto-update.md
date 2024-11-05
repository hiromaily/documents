# TIMESTAMP および DATETIME の自動初期化および更新機能

行更新時に自動で updated_at に現在時刻を設定する関数を定義するには、`trigger`の定義が必要

```sql
-- triggerを定義
-- 行が更新された時に、updated_atに現在時刻を設定
CREATE FUNCTION set_updated_at() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        NEW.updated_at := now();
        return NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- updated_atをもったtestsテーブルを作成
CREATE TABLE tests (
    id serial primary key,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UNIQUE(block_height)
);

-- testsテーブル更新時に自動でupdated_atが更新されるようにトリガーを設定
CREATE TRIGGER trg_tests_updated_at BEFORE UPDATE ON tests FOR EACH ROW EXECUTE PROCEDURE set_updated_at();
```
