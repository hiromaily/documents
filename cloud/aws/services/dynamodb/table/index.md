# DynamoDBで使われるIndex

**インデックス**は、特定の属性でデータを効率的に検索するために使用される。

- **ローカルセカンダリインデックス（LSI）**:

  - 同じパーティションキーを共有しながら、異なるソートキーを持つアイテムを効率的に検索するために使用される。
  - テーブル作成時にのみ追加可能。

- **グローバルセカンダリインデックス（GSI）**:
  - テーブルとは異なるパーティションキーとソートキーを持つことができ、テーブル作成後に追加可能。
  - 全テーブルにまたがって、別のキーを基にデータを効率的に検索できる。