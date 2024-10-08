# UUID

`UUID（Universally Unique Identifier）`とは、広く使われることでユニーク（唯一無二）であると保証される識別子（ID）のことを指す。これは特に分散システムやネットワークでノードやリソースを一意に識別するために頻繁に使われる。UUID は`128ビット`の長さを持ち、一般的には`16進数の形式`として表現される。
UUID は高度な一意性を保証し、複雑なシステムでのリソースおよびエンティティの識別において非常に有用なツール。

[内部Docs:DB のユニークキー](../database/uuid.md#db-のユニークキー)

## バージョン

UUID にはいくつかのバージョンとバリエーションが存在し、それぞれ異なる生成方法や用途がある。

### バージョン 1：タイムベース UUID

バージョン 1 の UUID は、時間とデバイス（MAC アドレス）に基づいて生成される。これは、偽造が比較的困難であり、極めて高い一意性を提供する。しかし、MAC アドレスから作成されるため、一部のプライバシー懸念が生じる。

### バージョン 2：DCE Security UUID

バージョン 2 は DCE（Distributed Computing Environment）セキュリティに関連して使われるが、典型的な用法ではあまり見かけられない。これも時刻に基づいているが、追加のセキュリティ情報が含まれる。

### バージョン 3：名前ベース UUID（MD5）

バージョン 3 は、名前空間と名前のハッシュ値（MD5）に基づいて生成される。名前空間として指定される文字列（例えば、URL や DNS 名）と、実際の名前から一意の UUID を生成する。

### バージョン 4：ランダム UUID

バージョン 4 は、完全にランダムな値に基づいて UUID を生成する。そのため、真のユニーク性は一部の統計的限界に依存するが、非常に高い確率で一意になる。このバージョンは実装もシンプルで、プライバシー懸念も少なく、最も広く使われている。

### バージョン 5：名前ベース UUID（SHA-1）

バージョン 5 は、バージョン 3 と似ているが、ハッシュアルゴリズムとして SHA-1 を使用する。これは MD5 よりも強力なハッシュを提供するため、一部の用途ではこのバージョンが選ばれることがある。

## UUID の構造

UUID は通常、`8-4-4-4-12` の形式で表される。これは、`32 桁の 16 進数`を 4 つのダッシュで区切った形式。

```txt
550e8400-e29b-41d4-a716-446655440000
```

各部分は以下の情報を持つ：

- 最初の 8 桁：タイムスタンプまたはランダム数
- 次の 4 桁：タイムスタンプまたはランダム数
- 次の 4 桁：バージョン情報（例：バージョン 1 の場合、最上位の桁は 1）
- 次の 4 桁：ランダム数または MAC アドレスの一部
- 最後の 12 桁：ランダム数または MAC アドレスの残りの部分

## UUID の利用例

- データベース主キー
- 分散システムでのノード識別
- ファイルシステムにおけるファイル識別
- コンフィギュレーションや設定ファイルの一意識別
