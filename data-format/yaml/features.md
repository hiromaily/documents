# YAMLの構文詳細

## インデントとホワイトスペース

- YAMLでは、インデントが重要。スペースを使用し、`タブは避けるべき`。
- 同じ階層の要素は同じインデントレベルで配置する。

## 文字列

- `クオートで囲むことも囲まないことも可能`。
- クオートで囲む場合、ダブルクオートとシングルクオートの両方が使える。

```yaml
unquoted: This is an unquoted string.
single_quoted: 'This is a single quoted string.'
double_quoted: "This is a double quoted string."
```

## 複数行の文字列

複数行の文字列を扱う場合、パイプ（`|`）や大なり記号（`>`）を使う。

- パイプ (`|`)は改行を保持。
- 大なり記号 (`>`)は改行をスペースに変換。

```yaml
literal_block: |
  This is a
  multi-line string.
folded_block: >
  This is a
  folded string,
  which means newlines become spaces.
```

## アンカーとエイリアス

YAMLのアンカー（anchor）とエイリアス（alias）は、データの再利用と重複を避けるための機能。この機能を使うことで、一度定義したデータを文書内の複数の場所で再利用できる。

### アンカーとエイリアスの基本

- **アンカー（anchor）**: 値を定義し、それに名前を付ける。アンカーは `&` を使って定義される。
- **エイリアス（alias）**: 既存のアンカーの値を参照する。エイリアスは `*` を使って定義される。

### 基本例

以下はシンプルなアンカーとエイリアスの例：

```yaml
default_settings: &default
  adapter: postgresql
  host: localhost
  port: 5432

development:
  database: dev_db
  <<: *default

test:
  database: test_db
  <<: *default

production:
  database: prod_db
  <<: *default
  host: prod-db.example.com
```

### アンカーとエイリアスの詳細

1. **基本形式**

   アンカーを定義するには、値に `&` を加えて名前を付ける。エイリアスを使用するには、値に `*` を加えてアンカー名を指定する。

   ```yaml
   base: &base_anchor
     name: Default Name
     age: 0

   person1:
     <<: *base_anchor
     name: John Doe
     age: 30

   person2:
     <<: *base_anchor
     name: Alice Smith
   ```

   ここで、`&base_anchor` はアンカーを定義し、`*base_anchor` はエイリアスを使用してそのアンカーの値を再利用している。

2. **マージキー（`<<`）**

   追加のマージキー `<<` を使うことで、アンカーの内容を含むマッピングへ簡単に値をマージできる。これにより、親の設定を継承しつつ、個別の設定を上書きできる。

   ```yaml
   base: &base_anchor
     name: Default Name
     age: 0
     country: Neverland

   person:
     <<: *base_anchor
     name: John Doe
     age: 30
   ```

   ここで、`person` は `base` マッピングから値を継承しつつ、`name` と `age` を上書きしている。

### 複雑な例

次に、より複雑な例を示す。ここでは、リスト（配列）やネストしたオブジェクトでもアンカーとエイリアスを使用する。

```yaml
# 基本設定の定義
defaults: &defaults
  adapter: postgresql
  host: localhost
  port: 5432
  pool: 5

development:
  <<: *defaults
  database: dev_db

test:
  <<: *defaults
  database: test_db

production:
  <<: *defaults
  database: prod_db
  host: prod-db.example.com

# ネストしたオブジェクトの例
block: &block
  key1: value1
  key2:
    subkey: subvalue

complex_structure:
  base: *block
  additional:
    key3: value3
    key4: value4
```

### 実際の利用シナリオ

#### 設定ファイル

多くのアプリケーションでは、環境（開発、テスト、プロダクション）ごとに異なる設定を持つ。これらの設定の大部分が共通であり、一部だけが異なる場合、アンカーとエイリアスを使って共通設定を一度定義し、必要に応じて上書きすることができる。

```yaml
defaults: &defaults
  adapter: mysql
  pool: 5
  timeout: 5000

development:
  <<: *defaults
  database: dev_db

test:
  <<: *defaults
  database: test_db

production:
  <<: *defaults
  database: prod_db
  pool: 10  # プロダクションではプールサイズを増やす
```

#### 多言語対応

多言語対応のアプリケーションでは、同じ文言の異なる言語版が必要となる。この場合も、アンカーとエイリアスが役立つ。

```yaml
en: &EN
  greeting: "Hello"
  farewell: "Goodbye"

es:
  <<: *EN
  greeting: "Hola"
  farewell: "Adiós"

fr:
  <<: *EN
  greeting: "Bonjour"
  farewell: "Au revoir"
```

このように、アンカーとエイリアスを効果的に使うことで、YAMLファイルのサイズを縮小し、管理しやすくなる。データの重複を避け、一貫性のある設定ファイルを簡単に作成できるのが、アンカーとエイリアスの最大の利点。
