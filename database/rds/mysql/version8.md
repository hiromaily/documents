# MySQL 8.0 の新機能

MySQL 8.0 は、MySQL のこれまでのバージョンと比較して多くの新機能と改良が導入された。

## 1. **パフォーマンス改善**

- **一般的なパフォーマンス向上**:

  - JSON 処理の高速化。
  - インデックスのアルゴリズムの改善。
  - バイナリログとリレーログの処理の最適化。

- **Redone の書き込み圧縮**: InnoDB ログファイルの書き込みが圧縮され、ディスク I/O の負荷が軽減。

## 2. **データ型と演算子**

- **ウィンドウ関数**: SQL 標準に準拠したウィンドウ関数が追加され、複雑な分析クエリが簡素化。

  ```sql
  SELECT name, salary,
         RANK() OVER (PARTITION BY department ORDER BY salary DESC) as rank
  FROM employees;
  ```

- **Common Table Expressions (CTEs)**:

  - 再帰的および非再帰的な CTE がサポートされるようになった。

  ```sql
  WITH RECURSIVE cte AS (
      SELECT 1 AS n
      UNION ALL
      SELECT n + 1 FROM cte WHERE n < 5
  )
  SELECT * FROM cte;
  ```

- **永続的生成カラム(Persisted Generated Columns)**: 仮想ではなく、ディスクに永続化される生成カラムをサポート。

## 3. **JSON サポートの拡充**

- **JSON テーブル関数**: JSON データを構造化されたテーブル形式に変換。

  ```sql
  SELECT * FROM JSON_TABLE(json_column, '$.path'
                           COLUMNS (column_name DATA_TYPE PATH '$.subpath')) AS jt;
  ```

- **JSON の演算子と関数**: JSON 値を操作するための新しい演算子と関数が追加。

## 4. **セキュリティと認証**

- **パスワードの難読化**: `caching_sha2_password`プラグインがデフォルトの認証プラグインに。
- **ロール**: データベースユーザーにロールを割り当て、そのロールを使用して権限管理を簡略化。

  ```sql
  CREATE ROLE 'app_read', 'app_write';
  GRANT SELECT ON database.* TO 'app_read';
  GRANT INSERT, UPDATE ON database.* TO 'app_write';
  ```

## 5. **インデックス**

- **逆インデックス**: 全文検索用の逆インデックスサポート。
- **Invisible Indexes**: アクティブではない（クエリ最適化に影響を与えない）インデックスの作成が可能。

## 6. **レプリケーション**

- **組み込みレプリケーション解析**: 自動フェールオーバー、および優れた監視機能。
- **GTID (Global Transaction Identifiers)の改善**: Online GTID の有効化と管理が簡略化。

## 7. **空間データのサポート**

- **空間インデックスの改良**: 空間インデックスのパフォーマンスが向上。

- **GeoJSON**: GeoJSON 形式のデータをサポート。

## 8. **オプティマイザー**

- **Histograms**: データ分布を理解して実行計画を最適化するためのヒストグラムをサポート。

- **コストベースオプティマイザー**: クエリの実行計画を選択する際に、より高度なコストベースロジックを使用。

## 9. **管理と操作**

- **Conflicting Server IDs の自動検出**: レプリケーション設定におけるサーバー ID の衝突を自動で検出。

- **一貫性チェックツール**: テーブルと INDEX の一貫性をチェックするツールが追加。

## [GTID-based レプリケーションにおける制限の緩和](https://dev.mysql.com/doc/refman/8.0/en/replication-gtids-restrictions.html)

`5.7` では、`CREATE TEMPORARY TABLE`や`CREATE TABLE ... SELECT`ステートメントを使っている場合、レプリケーション構成では使用できなかったが、`8.0.21` で、利用可能になった
