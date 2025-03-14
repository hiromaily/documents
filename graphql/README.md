# GraphQL

GraphQL は、Facebook によって開発された`クエリ言語`および`サーバーの実行エンジン`で、`クライアントがデータをどのように取得するかを柔軟に制御できるようにするもの`。REST の代替手段としてよく使われ、データ取得の効率性と柔軟性が特徴

## 主な特徴

### クエリ言語

- クライアントは、必要なデータの形状を具体的に定義するクエリを送信する。そのため、過剰なデータの取得を避けることができる。
  - Overfetch/Underfetch の解消
- クエリ例：

  ```graphql
  {
    user(id: "1") {
      name
      age
      posts {
        title
        content
      }
    }
  }
  ```

### 型システム

- GraphQL のスキーマは、データの形状と型を定義する。これにより、どのクエリが有効であるか、どのデータ型が返されるかを事前に把握できる。

### 単一エンドポイント

- REST API がリソースごとに異なるエンドポイントを持つのに対し、GraphQL では単一のエンドポイントに対してクエリを送信する。

### リアルタイム更新

- GraphQL サブスクリプションを使うことで、クライアントはデータのリアルタイム更新を受け取ることができる。

### スキーマ駆動開発

- GraphQL Schema の定義に従い、静的解析が可能で Linter を作ることができる

## 利点

- **柔軟性**: クライアントは要求するデータだけを取得できる。
- **効率性**: 一度のリクエストで必要なデータをすべて取得できる。
- **型の整合性**: スキーマに基づいた厳密な型チェックにより、バグの早期発見が可能。

## References

- [Official](https://graphql.org/)
- [Schema-First vs Code-Only GraphQL](https://www.apollographql.com/blog/backend/architecture/schema-first-vs-code-only-graphql/)
- [Awesome-GraphQL](https://github.com/chentsulin/awesome-graphql)
- [Principled GraphQL](https://principledgraphql.com/)
- [GraphQL Best Practices](https://graphql.org/learn/best-practices/)
- [2021: Netflix は迅速なアプリケーション開発のために GraphQL マイクロサービスを擁した](https://www.infoq.com/jp/news/2021/05/netflix-graphql-microservices/)
- [2021: LayerX GraphQL でバックエンドのコードをすっきりさせた話](https://tech.layerx.co.jp/entry/2021/04/12/121427)
- [2021: GraphQL を利用したアーキテクチャの勘所](https://speakerdeck.com/qsona/architecture-practices-with-graphql)
- [2021: GraphQL が解決する問題とその先のユースケース](https://zenn.dev/shunjuio/articles/07f1351a6b0049)
- [2022: GraphQL 実践ノウハウ](https://speakerdeck.com/sonatard/graphql-knowhow)
