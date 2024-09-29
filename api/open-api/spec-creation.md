# Spec の作成手段について

## OpenAPI spec の作成ができる Tool やサービス

- [openapi-gui](https://github.com/Mermade/openapi-gui)
  - OpenSource
  - OpenAPI 3.1.0 には未対応
  - [Mermade/openapi-gui を使って OpenAPI(Swagger)仕様書を作る](https://zenn.dev/dozo/articles/9a70e5b116f7e6)
- [Stoplight](https://stoplight.io/)

  - OpenAPI 定義ファイルの作成と管理ができる GUI エディタ
    - [Stoplight Studio](https://stoplight.io/studio)
  - [Stoplight と OpenAPI generator で API 開発をより便利にする](https://tech.talentx.co.jp/entry/2024/04/09/133904)
  - 有償

- [Redocly](https://redocly.com/)

  - [redocly-cli](https://github.com/Redocly/redocly-cli)によって spec の lint ができる
  - [Generate code samples automatically with Redocly](https://www.youtube.com/watch?v=zZUR7ih2A5A)
  - vscode の拡張により、コードアシストできる
  - 個人利用は無料

- [SwaggerHub](https://swagger.io/tools/swaggerhub/)
- [Postman](https://www.postman.com/)
- [APIMatic](https://www.apimatic.io/)

### [openapi-gui](https://github.com/Mermade/openapi-gui)

```sh
git clone https://github.com/Mermade/openapi-gui.git
cd openapi-gui
docker build -t mermade/openapi-gui .

# 実行
docker run --name openapi-gui -p 3000:3000 -d mermade/openapi-gui
```

![openapi-gui](https://github.com/hiromaily/documents/raw/main/images/openapi-gui.png "openapi-gui")

## DSL 等からの Spec 生成

- [CUE](./cue.md)
  - データの表現やスキーマ定義やバリデーションなどを行うことができる言語
