# SQL Anti パターン

SQL のアンチパターンは、データベース設計やクエリにおける望ましくない慣行や手法のことを指す。これらのアンチパターンは、`パフォーマンスの低下`、`保守の難易度増加`、`データの一貫性の問題`などを引き起こす可能性がある

SQL のアンチパターンを避けることで、データベースの設計や運用がより効率よく、信頼性の高いものになる。適切な設計とクエリの書き方を心がけることが重要。

## 1. **EAV（Entity-Attribute-Value）パターン**

- **問題点**: このパターンでは、異なる属性を持つエンティティを管理するために、属性名とその値を別のテーブルに格納する。これによりスキーマが柔軟になるが、クエリが複雑化し、性能が低下する。
- **例**:

  ```sql
  CREATE TABLE eav (
      entity_id INT,
      attribute_name VARCHAR(255),
      attribute_value VARCHAR(255)
  );
  ```

## 2. **スパースカラム**

- **問題点**: 各行が多数の NULL 値を持つテーブルを設計すること。これはストレージ効率が悪くなり、パフォーマンスが低下する
- **例**:

  ```sql
  CREATE TABLE product (
      product_id INT,
      color VARCHAR(50) NULL,
      size VARCHAR(50) NULL,
      weight FLOAT NULL
  );
  ```

## 3. **返しすぎるクエリ**

- **問題点**: 必要以上に多くのデータを返すクエリを書くこと。これによりネットワーク帯域が無駄になり、クライアント側での処理が増える。
- **例**:

  ```sql
  SELECT * FROM orders;
  ```

## 4. **インデックスの過剰使用または不足**

- **問題点**: インデックスはクエリパフォーマンスを向上させるが、過剰に設定すると更新や挿入の性能が低下する。一方で、必要なインデックスが不足すると、検索のパフォーマンスが悪化する。

## 5. **NOR（Normalization Of Relations）過剰または不足**

- **問題点**: 正規化しすぎるとクエリが複雑になりパフォーマンスが低下する。逆に正規化を不足させるとデータの重複や不整合が起こりやすい。
- **例**:
  - 3NF（第三正規形）以上に分割しすぎる
  - 正規化不足で同じ情報を複数のテーブルに持たせる

## 6. **アトリビュートのミスマッチ**

- **問題点**: 異なる型のデータを同じカラムに保存すること。これによりデータの一貫性が保たれなくなる。
- **例**:

  ```sql
  CREATE TABLE settings (
      name VARCHAR(255),
      age VARCHAR(10) -- Integerのほうが望ましい
  );
  ```

## 7. **プレースホルダの未使用**

- **問題点**: プレースホルダを使わずクエリに直接値を埋め込む。これにより SQL インジェクションのリスクが増大する。
- **例**:

  ```sql
  -- 悪い例
  EXECUTE IMMEDIATE 'SELECT * FROM users WHERE username = ''' || username || ''' AND password = ''' || password || '''';

  -- 良い例
  PREPARE stmt FROM 'SELECT * FROM users WHERE username = ? AND password = ?';
  EXECUTE stmt USING @username, @password;
  ```

## 8. **マジックナンバーのハードコード**

- **問題点**: テーブルやカラムに特定の値をハードコードすると、仕様変更時にコードが壊れやすくなる。
- **例**:

  ```sql
  SELECT * FROM orders WHERE status = 1;
  ```
