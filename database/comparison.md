# Database 比較

![db-comparison](https://github.com/hiromaily/documents/raw/main/images/db-comparison.webp "db-comparison")

## MySQL と PostgreSQL について

MySQL と PostgreSQL はどちらも、データの保存、整理、および管理に使用される一般的なリレーショナル データベース管理システム (RDBMS) 。 ただし、この 2 つにはいくつかの重要な違いがあり、一方が他方よりもニーズに適している場合がある。
最終的に、MySQL と PostgreSQL のどちらを選択するかは、特定のニーズとアプリケーションの要件によって異なる
。 複雑なデータ型と拡張機能を処理でき、データの整合性を優先できるデータベースが必要な場合は、PostgreSQL の方が適している可能性がある。 読み取りおよび書き込み操作が高速で、従来のレプリケーション方法で簡単にスケーリングできるデータベースが必要な場合は、MySQL がより適切な選択肢となる可能性がある。

- [技術選定の失敗 2 年間を振り返る TypeScript,Hono,Nest.js,React,GraphQL](https://zenn.dev/nem/articles/ade7b83cae2fa5)
  - MySQL に優位性はないとのこと
    - RLS がない
      - セッションごとに論理的に DB を分離できる機能
        - 例えば A 社のユーザーから B 社のレコードを隠すことができる
      - id が実質連番一択になる (UUID を使えない)
        - これは PostgreSQL でも同様では？

## MySQL と PostgreSQL の違い

| MySQL                                                                       | PostgreSQL                                 |
| --------------------------------------------------------------------------- | ------------------------------------------ |
| DDL 作成時にコメントの追加が 1 行でできる                                   | `COMMENT ON COLUMN`文を別途用意            |
| 配列型がなく、JSON を使えるが、検索に弱い                                   | 配列型が使える                             |
| `ON UPDATE`により、データ更新時に日時の自動更新ができる                     | trigger を使う必要がある                   |
| UUID 型はパフォーマンス的に難があり、回避方法が複雑                         | MySQL と同様で`v7`対応待ち                 |
| enum を独立した型として利用できない。table のカラムに直接記述する必要がある | enum 型を定義して他の table から利用できる |

- `enum` は Anti パターンなので、重要ではない

### 1. データの種類と拡張子

- PostgreSQL は、配列、範囲、ユーザー定義型など、MySQL よりも幅広いデータ型をサポートしている。
- PostgreSQL では、ユーザーがデータベースの機能を拡張するために使用できる独自の関数、演算子、および集計を定義することもできる。
- 一方、MySQL は、より限定されたデータ型と拡張子のセットをサポートしり。

### 2. ACID コンプライアンス

- MySQL と PostgreSQL はどちらも ACID に準拠しているため、データ トランザクションの信頼性と一貫性が保証される。
- ただし、PostgreSQL は MySQL よりも強力な ACID 準拠であることが知られており、これは高レベルのデータ整合性を必要とするアプリケーションにとって重要な場合がある。

### 3. パフォーマンス

- 読み取りおよび書き込み操作に関しては、MySQL は一般に PostgreSQL よりも高速であると考えられている。
- ただし、PostgreSQL は、より高度なクエリ オプティマイザーとより高度なインデックス作成手法のサポートにより、複雑なクエリや分析ワークロードに好まれることがよくある。

### 4. スケーラビリティ

- MySQL と PostgreSQL はどちらもスケーラブルになるように設計されていますが、これを実現するために異なるアプローチを使用している。
- MySQL は従来のマスター/スレーブ レプリケーション モデルを使用するが、PostgreSQL はより高度なマスター/スタンバイ レプリケーション モデルを使用して、より優れたフォールト トレランスと負荷分散を可能にする。

### 5. ライセンス

- MySQL は GPL またはプロプライエタリ ライセンスに基づいてライセンスされている
- PostgreSQL は寛容な MIT ライセンスに基づいてライセンスされている
- これは、PostgreSQL が MySQL よりも自由に使用および変更できることを意味する

## RDBMS と NoSQL Database の使い分けについて

### RDBMS が良い場合

- 複雑なクエリとトランザクションが求められる場合
  - アプリケーションが複数のテーブル間の複雑な Query、Join、トランザクションを必要とする場合
  - 例: 金融システム、ERP（エンタープライズリソースプランニング）、CRM（カスタマーリレーションシップマネジメント）システム等
- 関係を持つ構造化データ
  - データが高度に構造化され、エンティティ間の関係が重要な場合、リレーショナルデータベースはこれらの関係を維持するのに優れている
  - 例: 在庫管理、注文処理、データの整合性と一貫性が重要なシステム等
- ACID 特性
  - アプリケーションが強い一貫性、原子性、分離性、耐久性（ACID 特性）を必要とする場合、リレーショナルデータベースがこれらの要件を満たす
  - 例: 銀行アプリケーション、トランザクションシステム、一貫したデータが必要なシステム
- 標準化されたスキーマ
  - データモデルが安定しており、事前に固定スキーマを定義できる場合、リレーショナルデータベースは堅牢なスキーマ管理を提供する
  - 例: 従業員データベース、固定レポートシステム、予測可能なデータ構造を持つアプリケーション

### NoSQL が良い場合

- 高性能とスケーラビリティ
  - アプリケーションが大量の読み取り・書き込みを低遅延で処理する必要がある場合、NoSQL データベース（例えば Redis）は高性能で水平スケーリングが可能
  - 例: リアルタイム分析、セッションストレージ、キャッシュレイヤー
- 柔軟なスキーマ
  - データモデルが動的であり、時間とともに進化する場合、NoSQL データベースはスキーマの柔軟性を提供する
  - 例: コンテンツ管理システム、ソーシャルネットワーク、多様で進化するデータ構造を持つアプリケーション
- 大量のデータ
  - アプリケーションが大量の非構造化または半構造化データを扱う場合、NoSQL データベースは効率的にデータを管理する
  - 例: ビッグデータアプリケーション、IoT データストレージ、ログ管理システム
- 分散データ
  - アプリケーションが複数の場所やデータセンターに分散される必要がある場合、NoSQL データベースは分散アーキテクチャをサポートする
  - 例: グローバルアプリケーション、災害復旧システム、地域間のデータレプリケーションが必要なアプリケーション
- 特定のユースケース
  - NoSQL データベースは特定のユースケースに最適化されており、例えば、Redis はキャッシュ、インメモリデータストレージ、リアルタイム分析に優れている
  - 例: ゲームのリーダーボード、リアルタイムチャットアプリケーション、ライブデータフィード

### 比較のまとめ

| 基準                 | リレーショナルデータベース                 | NoSQL データベース                        |
| -------------------- | ------------------------------------------ | ----------------------------------------- |
| **データ構造**       | 固定スキーマの構造化データ                 | 柔軟で非構造化データも対応                |
| **トランザクション** | ACID トランザクションをサポート            | 場合による、通常は最終的整合性            |
| **クエリの複雑さ**   | 複雑なクエリとジョインをサポート           | クエリ機能は限定的、シンプルな検索        |
| **スケーラビリティ** | 垂直スケーリング                           | 水平スケーリング                          |
| **パフォーマンス**   | 読み書き操作に対して中程度のパフォーマンス | 高パフォーマンス、低遅延                  |
| **ユースケースの例** | 銀行業務、ERP、CRM                         | リアルタイム分析、IoT、ソーシャルメディア |

### 判断方法

- 要件の分析
  - アプリケーションのコア要件（パフォーマンス、一貫性、スケーラビリティ、クエリの複雑さなど）をリストアップする
- データの特性を評価
  - データの性質（構造化 vs. 非構造化）、データ量、データの変更頻度を確認する
- 将来の成長を考慮
  - データの成長の可能性と将来のスケーラビリティの必要性を評価する
- プロトタイプとテスト
  - どちらを選ぶか迷った場合、両方のデータベースを使ってプロトタイプを作成し、ベンチマークテストを行って、どちらがニーズに合うか評価
