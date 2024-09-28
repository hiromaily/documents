# OpenAPI Generator

**OpenAPITools/openapi-generator**は、OpenAPI Specification（Swagger）に基づいて、クライアント SDK、サーバースタブ、API ドキュメントなどを自動生成するためのオープンソースツールであり、GitHub 上のリポジトリでホストされている。

## 主な特徴

1. **多言語対応**：Java、Python、PHP、Ruby、C#、Go、JavaScript など、多数のプログラミング言語に対応している。
2. **豊富なテンプレート**：さまざまなテンプレートが用意されており、目的に応じたコードを生成できる。
3. **カスタマイズ可能**：Mustache テンプレートエンジンを使ってカスタマイズが可能。
4. **CLI サポート**：コマンドラインインターフェース（CLI）を通じて簡単に使うことができる。
5. **プラグインサポート**：Maven、Gradle などのビルドツール向けのプラグインも提供している。
6. **活発なコミュニティ**：オープンソースなので、世界中の開発者が参加して機能追加やバグ修正が行われている。

## 主な利用方法

OpenAPI 定義ファイル（通常は JSON または YAML）を元にコードを生成する。以下は基本的な利用手順。

1. **OpenAPI 定義ファイルの準備**：API の定義を記述した OpenAPI Specification ファイルを用意する。

2. **インストール**：CLI ツールとしてインストールする方法がある。

   **Java 版の直接実行**

   ```sh
   java -jar openapi-generator-cli.jar generate -i petstore.yaml -g java -o /tmp/java-client
   ```

   **Docker 版の利用**

   ```sh
   docker run --rm -v ${PWD}:/local openapitools/openapi-generator-cli generate \
       -i /local/petstore.yaml \
       -g java \
       -o /local/out/java
   ```

3. **コマンドによるコード生成**：

   ```sh
   openapi-generator-cli generate -i petstore.yaml -g java -o /tmp/java-client
   ```

   ここで、`-i`オプションは入力ファイルを指定し、`-g`オプションは生成するコードの言語を指定、`-o`オプションは出力ディレクトリを指定する。

## 主なコマンドラインオプション

- `generate`：コードを生成するメインコマンド

  - `-g`：コード生成のテンプレート（例：java、python、spring など）
  - `-i`：入力の OpenAPI ファイル
  - `-o`：出力ディレクトリ

- `config-help`：特定のテンプレートに必要な設定オプションを表示

  ```sh
  openapi-generator-cli config-help -g java
  ```

- `meta`：カスタムジェネレータを作成するためのテンプレートを生成

  ```sh
  openapi-generator-cli meta
  ```

## プロジェクトの構成

プロジェクトのディレクトリは以下のような構成になっています。

- `modules`：主要モジュール（コードジェネレーターのテンプレートやプラグインなど）
- `samples`：さまざまな言語やプラットフォームのサンプルコード
- `bin`：CLI 用のスクリプトや実行可能ファイル
- `docs`：ドキュメント類

## References

- [openapi-generator](https://github.com/OpenAPITools/openapi-generator)
- [対応する言語, framework](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators.md)
- [OpenAPI Generator](https://openapi-generator.tech/)の使い方

### [Go](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/go.md)

- [gin](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/go-gin-server.md?plain=1)
- [echo](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/go-echo-server.md)

### [Rust](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/rust.md)

- [axum](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/rust-server.md)

### [Typescript](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/typescript.md)

- [nestjs](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/typescript-nestjs.md)
- [axios](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/typescript-axios.md)
- [fetch](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/typescript-fetch.md)
