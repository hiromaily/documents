# GraphQLを使った開発

GraphQLのシステム構築は、`スキーマの定義`、`リゾルバーの作成`、`サーバーのセットアップ`、そして`テスト`という手順に沿って進める。Goでは、`graphql-go`ライブラリを用いて柔軟かつ効率的にGraphQLサーバーを構築できる。

- GraphQL のスキーマを定義
- GraphQL サーバ
  - スキーマとデータソースを結びつける機能を持つリゾルバを実装する
- GraphQL クライアント
  - GraphQL クエリを実行

ここでは、`Golang`を使った開発手順の例をここに示す

## 1. 必要なパッケージをインストール

GraphQLサーバーを構築するために、`graphql-go`や`go-chi`などのパッケージをインストールする

```sh
go get github.com/graphql-go/graphql
go get github.com/go-chi/chi/v5
go get github.com/rs/cors
```

## 2. スキーマを定義する

GraphQLのスキーマを定義する。まずは基本的な`ユーザー型`と`クエリ`を定義するファイルを作成する。

例として、`schema.go`を作成する。

```go
package main

import (
    "github.com/graphql-go/graphql"
)

// User型を定義
var userType = graphql.NewObject(graphql.ObjectConfig{
    Name: "User",
    Fields: graphql.Fields{
        "id":   &graphql.Field{Type: graphql.ID},
        "name": &graphql.Field{Type: graphql.String},
        "age":  &graphql.Field{Type: graphql.Int},
    },
})

// データリスト（メモリ内）
var users = []map[string]interface{}{
    {"id": "1", "name": "John Doe", "age": 28},
}

// クエリタイプを定義
var queryType = graphql.NewObject(graphql.ObjectConfig{
    Name: "Query",
    Fields: graphql.Fields{
        "users": &graphql.Field{
            Type: graphql.NewList(userType),
            Resolve: func(params graphql.ResolveParams) (interface{}, error) {
                return users, nil
            },
        },
        "user": &graphql.Field{
            Type: userType,
            Args: graphql.FieldConfigArgument{
                "id": &graphql.ArgumentConfig{Type: graphql.ID},
            },
            // リゾルバー
            Resolve: func(params graphql.ResolveParams) (interface{}, error) {
                id, ok := params.Args["id"].(string)
                if ok {
                    for _, user := range users {
                        if user["id"] == id {
                            return user, nil
                        }
                    }
                }
                return nil, nil
            },
        },
    },
})

// ミューテーションタイプを定義
var mutationType = graphql.NewObject(graphql.ObjectConfig{
    Name: "Mutation",
    Fields: graphql.Fields{
        "addUser": &graphql.Field{
            Type: userType,
            Args: graphql.FieldConfigArgument{
                "name": &graphql.ArgumentConfig{Type: graphql.String},
                "age":  &graphql.ArgumentConfig{Type: graphql.Int},
            },
            Resolve: func(params graphql.ResolveParams) (interface{}, error) {
                name, nameOk := params.Args["name"].(string)
                age, ageOk := params.Args["age"].(int)

                if nameOk && ageOk {
                    newUser := map[string]interface{}{
                        "id":   string(len(users) + 1),
                        "name": name,
                        "age":  age,
                    }
                    users = append(users, newUser)
                    return newUser, nil
                }
                return nil, nil
            },
        },
    },
})

// スキーマを作成
var schema, _ = graphql.NewSchema(graphql.SchemaConfig{
    Query:    queryType,
    Mutation: mutationType,
})
```

## 3. サーバーをセットアップする

GoのHTTPサーバーをセットアップし、GraphQLエンドポイントを作成する。例として、`main.go`を作成する。

```go
package main

import (
    "encoding/json"
    "net/http"

    "github.com/graphql-go/graphql"
    "github.com/go-chi/chi/v5"
    "github.com/rs/cors"
)

func main() {
    r := chi.NewRouter()

    // CORSを許可
    c := cors.New(cors.Options{
        AllowedOrigins:   []string{"*"},
        AllowCredentials: true,
    })

    // GraphQLエンドポイントを定義
    r.Handle("/graphql", c.Handler(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        var params map[string]interface{}
        if err := json.NewDecoder(r.Body).Decode(&params); err != nil {
            http.Error(w, err.Error(), http.StatusBadRequest)
            return
        }

        result := graphql.Do(graphql.Params{
            Schema:        schema,
            RequestString: params["query"].(string),
        })

        if len(result.Errors) > 0 {
            http.Error(w, result.Errors[0].Message, http.StatusBadRequest)
            return
        }

        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(result)
    })))

    // サーバー起動
    http.ListenAndServe(":4000", r)
}
```

## 4. サーバーを起動する

サーバーを起動して動作することを確認する。

```sh
go run main.go
```

ブラウザで <http://localhost:4000/graphql> にアクセスし、クエリやミューテーションをPOSTリクエストで試すことができる。

## 5. クエリとミューテーションをテストする

PostmanやGraphQL Playgroundなどのツールを使ってクエリやミューテーションをテストする。

```json
# クエリ例 (POSTリクエストボディ)
{
  "query": "{ users { id name age }}"
}

# ミューテーション例 (POSTリクエストボディ)
{
  "query": "mutation { addUser(name: \"Alice\", age: 23) { id name age } }"
}
```

## Resolve リゾルバー

リゾルバーは、クライアントからGraphQLリクエストが送信されたときに適用され、スキーマで定義されたフィールドに対してどのようにデータを取得または操作するかを決定する。具体的には、Resolve関数内で必要なデータを取得し、これをクライアントに返す。
