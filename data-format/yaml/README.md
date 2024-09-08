# YAML

YAML（`YAML Ain't Markup Language`）は、データの設定や構成を表現するための人間に優しいフォーマット。YAMLは特に設定ファイルやデータシリアライゼーションの分野で広く用いられている。構文がシンプルで、読みやすく、編集しやすいのが特徴。

YAMLはその柔軟性と読みやすさから、多くのプロジェクトで設定ファイルやデータ交換フォーマットとして採用されている。YAMLを理解し、活用することで、より効果的に構造化データを管理できる。

## 基本構造

YAMLの基本構造は、インデントを利用してデータの階層構造を表現する。コロン（`:`）を使ってキーと値を区別し、ハイフン（`-`）を使ってリスト（配列）を表現する。

### キーと値（マッピング）

キーと値のペアは、コロン（`:`）で分けられる。インデントによりネストが表現される。

```yaml
name: John Doe
age: 30
address:
  street: 123 Main St
  city: Wonderland
```

### リスト

リスト（配列）の各要素はハイフン（`-`）を用いて表現される。

```yaml
names:
  - Alice
  - Bob
  - Charlie
```

### 複合データ

リストやマッピングをネストして複合データ構造を作成できる。

```yaml
employees:
  - name: John Doe
    age: 30
    position: Developer
  - name: Jane Smith
    age: 25
    position: Designer
```

## YAMLのデータ型

- **文字列**: クオートで囲む場合も囲まない場合もある。
- **数値**: 整数および浮動小数点。
- **ブール値**: `true` または `false`。
- **null**: `null` または `~` または空の値。
- **配列**: リスト型。
- **マッピング**: キーと値のペア。

## YAMLの特徴と利点

1. **読みやすさ**: 人間が読みやすい構文。インデントが階層を明確にし、見やすい。
2. **フォーマットの柔軟性**: JSONと互換性があり、他のフォーマット（例えば、XMLやTOMLなど）にも変換しやすい。
3. **コメントの付加**: `#`を使ってコメントを書ける。

## YAMLの利用例

### 設定ファイル

```yaml
version: 1.0
default: &default
  adapter: mysql
  host: localhost

development:
  <<: *default
  database: dev_db

test:
  <<: *default
  database: test_db

production:
  adapter: postgresql
  host: db.example.com
  database: prod_db
```

## YAMLのベストプラクティス

1. **一貫したインデント**: スペースを使用し、タブは避ける。
2. **コメントの活用**: 複雑な設定やデータを理解しやすくするためにコメントを追加。
3. **適切な命名規則**: キー名は意味が明確で一貫性のあるものを使用。
4. **ファイルサイズ管理**: 大規模なYAMLファイルでは、分割して管理することを検討。
