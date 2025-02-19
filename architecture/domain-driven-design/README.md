# ドメイン駆動設計 Domain-Driven Design、DDD

ドメイン駆動設計（Domain-Driven Design、略してDDD）は、エリック・エヴァンスが2003年に提唱した`ソフトウェア設計のアプローチ`で、特に複雑なビジネスロジックを持つシステムに向いている。DDDの主な目的は、`ビジネスドメイン（問題領域）を深く理解し、それに基づいてシステムを設計・開発すること`。

ドメイン駆動設計は複雑なビジネスロジックを扱うシステムに対して非常に有効だが、その適用には時間と労力がかかるため、プロジェクトの規模や複雑性に応じて検討することが重要。

アーキテクチャではなく開発手法。ドメイン駆動設計においてはドメインが隔離されることのみが重要

## DDDの基本概念

1. **ドメイン（Domain）**:
   - ドメインとは、特定のビジネスや活動領域の問題空間を指す。たとえば、電力供給、銀行業務、医療など、それぞれの業界特有の課題やニーズがドメインとなる。

2. **ユビキタス言語（Ubiquitous Language）**:
   - 開発チーム全体で共通して使う言葉を定義し、ドメインエキスパート（ビジネスの専門家）とエンジニアとの間で、一貫性のあるコミュニケーションを確立する。

3. **エンティティ（Entity）**:
   - 識別可能な一意のIDを持つオブジェクト。状態を持ち、その状態が変更されることがあるため、ライフサイクルが管理される。

4. **値オブジェクト（Value Object）**:
   - 一意のIDを持たないオブジェクトで、不変性が重視される。たとえば、「住所」や「通貨金額」などが値オブジェクトに該当する。

5. **アグリゲート（Aggregate）**:
   - 一つ以上のエンティティや値オブジェクトから成り、それらを一つの単位として扱う。アグリゲートの状態は「ルートエンティティ」で管理される。

6. **リポジトリ（Repository）**:
   - エンティティの永続化と取得を担当するオブジェクト。データベースへのアクセスを隠蔽し、高レベルの操作を提供する。

7. **ファクトリ（Factory）**:
   - 複雑なオブジェクトの生成を担当するオブジェクト。特にアグリゲートの生成を簡潔に行うために使用される。

## DDDの層（Layers）

DDDはしばしば以下のレイヤーで構成されたシステムアーキテクチャに基づいている。

1. **プレゼンテーション層（Presentation Layer）**:
   - ユーザーインターフェースやAPIなどの外部とのやり取りを担当する層。

2. **アプリケーション層（Application Layer）**:
   - ユースケースやアプリケーションロジックを取り扱う層。ビジネスロジック自体はここに含まれない。

3. **ドメイン層（Domain Layer）**:
   - `ビジネスロジック`、ルール、ステートマシンが含まれます。エンティティ、値オブジェクト、ドメインサービスなどがここに配置される。

4. **インフラストラクチャ層（Infrastructure Layer）**:
   - データベースアクセス、外部APIとの通信、ファイルシステムとのやり取りなど、システムを実行するための技術的な詳細が含まれる。

## DDDのメリット

1. **ビジネスロジックの明示化**:
   - ドメインエキスパートの知識をコードに直接反映させることで、ビジネスロジックが明確になる。

2. **柔軟性と再利用性**:
   - 高度に分割されたモジュール構造により、システムの変更や拡張が容易になる。

3. **一貫性のあるコミュニケーション**:
   - ユビキタス言語により、非技術者と技術者の間でのコミュニケーションがスムーズになる。

## DDDの課題

1. **初期コスト**:
   - ドメイン理解と設計に時間がかかるため、初期段階でのコストが高くなることがある。

2. **複雑性**:
   - すべてのプロジェクトに適しているわけではなく、単純な問題に対して複雑な設計を適用することで、過剰設計になるリスクもある。

3. **チームのスキル要件**:
   - チーム全体がDDDを理解し、実践するスキルを持つ必要がある。トレーニングや教育も重要。

## References

- [「ドメイン駆動設計をはじめよう」の感想](https://zenn.dev/penginpenguin/articles/4b934b6468d3cf)
- [2022: ドメイン駆動 + オニオンアーキテクチャ概略](https://qiita.com/little_hand_s/items/2040fba15d90b93fc124)
- [2020: ドメイン駆動設計を導入するために転職して最初の3ヶ月でやったこと](https://little-hands.hatenablog.com/entry/2020/12/22/ddd-in-first-3month)
- [CodeZine: ドメイン駆動設計とは何なのか？ ユーザーの業務知識をコードで表現する開発手法について](https://codezine.jp/article/detail/11968)
