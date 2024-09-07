# Schema 設計 (最重要)

GraphQL のスキーマ設計は、`APIの使いやすさ`、`メンテナンス性`、`パフォーマンス`などに直結する重要な部分となる

## スキーマ設計の基本

1. **エントリーポイントの定義**:

   - GraphQL スキーマは、主に`クエリ（Query）`、`ミューテーション（Mutation）`、`サブスクリプション（Subscription）`の 3 つのエントリーポイントで構成される。
   - クエリ（Query）: データの取得
   - ミューテーション（Mutation）: データの作成、更新、削除
   - サブスクリプション（Subscription）: リアルタイムのデータ更新

2. **主要なタイプの設計**:

   - 各エンティティ（例えば、User や Post など）について、GraphQL オブジェクトタイプを定義する。
   - 例:

     ```graphql
     type User {
       id: ID!
       name: String!
       email: String!
       age: Int
     }
     ```

3. **クエリとミューテーションフィールドの定義**:

   - ユーザーが必要とするデータを取得するためのクエリフィールド、データを操作するためのミューテーションフィールドを定義する。
   - 例:

     ```graphql
     type Query {
       user(id: ID!): User
       users: [User]
     }

     type Mutation {
       createUser(name: String!, email: String!, age: Int): User
       updateUser(id: ID!, name: String, email: String, age: Int): User
       deleteUser(id: ID!): User
     }
     ```

## 設計の詳細と注意点

1. **型の一貫性と重複排除**:

   - 同じエンティティに関するフィールドや型を一貫して使用し、不必要な重複を避ける。

   - 例えば、User オブジェクトを複数の場所で定義する場合、それぞれの定義が一貫していることを確認する。

2. **フィールドの選定**:

   - フロントエンドが実際に必要とするデータだけをフィールドに追加する。過剰なフィールドはパフォーマンスを低下させる。

3. **ネストされたフィールドとリレーション**:

   - データのリレーションシップを適切に定義し、必要なデータを取得できるようにする。

   - 例:

     ```graphql
     type User {
       id: ID!
       name: String!
       email: String!
       posts: [Post]
     }

     type Post {
       id: ID!
       title: String!
       content: String!
       author: User
     }
     ```

4. **入力タイプの利用**:

   - ミューテーションに必要な引数が多い場合、入力タイプ（Input Type）を利用することで、スキーマの読みやすさと使いやすさを向上させる。

   - 例:

     ```graphql
     input CreateUserInput {
       name: String!
       email: String!
       age: Int
     }

     type Mutation {
       createUser(input: CreateUserInput!): User
     }
     ```

5. **エラーハンドリング**:

   - GraphQL の標準的なエラーハンドリングメカニズムを活用し、ユーザーがエラー詳細を理解しやすくする。

   - 例:

     ```graphql
     type Error {
       message: String!
       code: Int
     }

     type Mutation {
       createUser(input: CreateUserInput!): CreateUserPayload
     }

     type CreateUserPayload {
       user: User
       errors: [Error]
     }
     ```

6. **バージョニングとスキーマの進化**:

   - API の成長や変更を念頭に置いてスキーマを設計する。非互換性のある変更は避け、可能な限り後方互換性を維持する。

7. **リソースのバランスとパフォーマンス**:
   - データ取得の負荷を適切に分散し、パフォーマンスを最適化するために、データローディングとネストの深さを考慮する。

## スキーマの具体例

以下に簡単なスキーマ全体を示す。

```graphql
# スキーマ定義
schema {
  query: Query
  mutation: Mutation
}

# タイプ定義
type User {
  id: ID!
  name: String!
  email: String!
  age: Int
  posts: [Post]
}

type Post {
  id: ID!
  title: String!
  content: String!
  author: User
}

# クエリ定義
type Query {
  users: [User]
  user(id: ID!): User
  posts: [Post]
  post(id: ID!): Post
}

# 入力タイプ定義
input CreateUserInput {
  name: String!
  email: String!
  age: Int
}

input UpdateUserInput {
  id: ID!
  name: String
  email: String
  age: Int
}

# ペイロード定義
type UserPayload {
  user: User
  errors: [Error]
}

type Error {
  message: String!
  code: Int
}

# ミューテーション定義
type Mutation {
  createUser(input: CreateUserInput!): UserPayload
  updateUser(input: UpdateUserInput!): UserPayload
  deleteUser(id: ID!): UserPayload
}
```

このようにスキーマを適切に設計することで、拡張性やメンテナンス性、パフォーマンスが向上する。API 利用者に対しても、直感的で使いやすいインターフェースを提供することができる。

## 個人的なスキーマ設計における所感

- Graph 構造を活かした設計にする。複数の Query が必要な設計にしない
- Front-end 側で受け取った型を変換するということは期待しない
- Query と Mutation で Schema 設計のポイントが異なる
