# フルテキスト検索

## フルテキスト検索のセットアップ

テーブルにテキストデータ型の列を追加し、フルテキスト検索用のトリガを設定する例

```sql
CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    content TEXT,
    tsvector_content TSVECTOR
);

-- トリガ設定
CREATE FUNCTION documents_tsvector_trigger() RETURNS TRIGGER AS $$
BEGIN
    NEW.tsvector_content := to_tsvector('english', NEW.content);
    RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON documents
FOR EACH ROW EXECUTE FUNCTION documents_tsvector_trigger();
```

## フルテキスト検索のクエリ

```sql
SELECT *
FROM documents
WHERE tsvector_content @@ to_tsquery('search_term');
```
