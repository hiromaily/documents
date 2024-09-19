# Goa Framework

## References

- [Design: Overview](https://goa.design/design/overview/)
- [Design: Overview (ja)](https://goa.design/ja/design/overview/)
- [Design: Types (may be outdated)](https://goa.design/design/types/)
- [Design: Types (ja)](https://goa.design/ja/design/types/)
- [Design: Upgrading](https://goa.design/learn/upgrading/)
- [Design: Upgrading (ja)](https://goa.design/ja/learn/upgrading/)
- [Goa DSL](https://pkg.go.dev/goa.design/goa/dsl)
- [Goa DSL: V3](https://pkg.go.dev/goa.design/goa/v3/dsl)
- [API Development in Go Using Goa](https://www.toptal.com/go/goa-api-development)

- 日本語Docs
  - [Goa v3 入門](https://zenn.dev/ikawaha/books/goa-design-v3/viewer/foreword)
  - [Goa v1 と v3 の DSL の比較](https://tchssk.hatenablog.com/entry/2019/10/24/192113)
  - [Goaをv1からv3にアップグレードしてみた](https://qiita.com/hirokisan/items/1905ef0c5642f84912d8)
  - [Goaで「HELLO WORLD」する](https://qiita.com/crml1206/items/ccdf62e713e3c9599fd5)
  - [Goa入門 - 簡単なCRUDを実装してみる](https://takakisan.com/golang-goa-beginner/)
  - [Goa v3でAPIキー認証(APIKeyAuth)を設定する](https://maya-zapiska.hateblo.jp/entry/2021/07/27/011305)
  - [新プロダクトでスモールチームを作りつつ、goaからgo-swaggerへの乗り換えていった話](https://tech.layerx.co.jp/entry/2021/04/23/191354)

## Designについて

```txt
API --- Service 1
     |- Service 2
     |- Service 3 --- Method 1
                   |- Method 2
                   |- Method 3
```

### API

- API定義。全体を通した説明, タイトル, どのURLで待ち受けるかなどの設定

```go
import cors "goa.design/plugins/v3/cors"

var _ = API("adder", func() {
    Title("title")                // Title used in documentation
    Description("description")    // Description used in documentation
    Version("2.0")                // Version of API
    TermsOfService("terms")       // Terms of use
    Contact(func() {              // Contact info
        Name("contact name")
        Email("contact email")
        URL("contact URL")
    })
    License(func() {              // License
        Name("license name")
        URL("license URL")
    })
    Docs(func() {                 // Documentation links
        Description("doc description")
        URL("doc URL")
    })

    // CORS using plugin
    cors.Origin("http://swagger.goa.design", func() { // Define CORS policy, may be prefixed with "*" wildcard
        cors.Headers("X-Shared-Secret")  // One or more authorized headers, use "*" to authorize all
        cors.Methods("GET", "POST")      // One or more authorized HTTP methods
        cors.Expose("X-Time")            // One or more headers exposed to clients
        cors.MaxAge(600)                 // How long to cache a preflight request response
        cors.Credentials()               // Sets Access-Control-Allow-Credentials header
    })

    // development/productionといったように複数の`Host`を定義できる
    Server("addersvr", func() {
        Services("calc", "something")

        Host("development", func() {
            URI("http://localhost:80")
            URI("grpc://localhost:8080")

            // Variable describes a URI variable.
            Variable("version", String, "API version", func() {
                // URI parameters must have a default value and/or an
                // enum validation.
                Default("v1")
            })
        })
    })
}
```

### Server

- サーバー定義

### Service

- 通常、APIの中に、複数のServiceが存在する。`user`, `production` といった複数のServiceに分けて定義する。
- 具体的なAPIのメソッドを定義していく。

### HTTP

- HTTPリクエストと、サービスのメソッドの関連付けを行う
- Service直下に定義したものが、Service内の共通の設定になり、共通の`PATH`を定義できる
- Method内は、それそれのGet, PostといったMethodの指定だったり、Responseのコードを定義できる

### Security

### Method

- Service内における、get, create といったmethodを定義していく
- HTTPのエンドポイントの定義

### Payload

- どんな値を受け取るか
- この中に定義する`Attribute`が値の名前と型を定義するもの

### Result

- 返り値の型を定義する

### View

### Attribute と Fieldの違い

## 開発メモ (TODO: go-goaのREADME.mdに移動する)

- [go-goa](https://github.com/hiromaily/go-goa)
- [Getting Started](https://goa.design/learn/getting-started/)

### Install

```sh
go install goa.design/goa/v3/cmd/goa@v3
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

### Design

- `<service-name>/design`ディレクトリ内にDSL定義をgoで作成していく

### 生成

- designが修正されるタイミングで実行する

```sh
goa gen resume/design
```

- goaのバージョンがupgradeされたタイミングなどで実行する
  - ここで生成されたファイルを修正し、ロジックを実装していく

```sh
goa example resume/design
```

- このタイミングで、生成された`cmd`を使ってendpointの確認を行う
  - serverを起動
  - endpointを確認してcurlコマンドを実行してみる

### Swaggerでの確認

- [Swagger Editor](https://editor.swagger.io/)にアクセス
- `goa gen`コマンドで生成された`gen/http`ディレクトリ配下に、openapiファイルが生成されているので、そちらを閲覧する
