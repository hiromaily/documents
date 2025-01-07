# GitHub Actions cache

## Note

[GitHub Actions cache](https://docs.docker.com/build/cache/backends/gha/)
Note: これは実験的な機能です。インターフェースと動作は不安定であり、将来のリリースで変更される可能性があると注意書きがある

## GitHub Actions キャッシュ

GitHub が提供するアクションのキャッシュ、または GitHub Actions キャッシュ プロトコルをサポートするその他のキャッシュ サービスを利用する。これは、ユースケースが GitHub によって設定されたサイズと使用量の制限内に収まる限り、GitHub Actions ワークフロー内で使用することが推奨されるキャッシュ。

このキャッシュ ストレージ バックエンドは、docker のデフォルトのドライバーではサポートされていないため、この機能を使用するには、別のドライバーを使用して新しいビルダーを作成する。

```sh
docker buildx build --push -t <registry>/<image> \
  --cache-to type=gha[,parameters...] \
  --cache-from type=gha[,parameters...] .
```

### `--cache-to`, `--cache-from`に利用可能なパラメータ

- `type`: 別途記載
- `url`: キャッシュ サーバーの URL
- `token`: アクセス トークン
- `scope`: キャッシュオブジェクトがどのスコープに属するか。
- `mode`: エクスポートするキャッシュ レイヤー
- `ignore-error`: キャッシュのエクスポートによって発生したエラーを無視するかどうか
- `timeout`: タイムアウトするまでのキャッシュのインポートまたはエクスポートの最大期間
- `repository`: キャッシュストレージに使用される GitHub リポジトリ
- `ghtoken`: GitHub API にアクセスするには GitHub トークンが必要

#### [Scope](https://docs.docker.com/build/cache/backends/gha/#scope)

スコープは、キャッシュ オブジェクトを識別するために使用されるキー。デフォルトでは `buildkit`に設定されている。複数のイメージをビルドする場合、各ビルドによって前のキャッシュが上書きされ、最終的なキャッシュのみが残る。

### [指定可能な`type`](https://docs.docker.com/reference/cli/docker/buildx/build/#cache-from)

[buildkit: GitHub Actions cache](https://github.com/moby/buildkit#github-actions-cache-experimental)

- `registry`: キャッシュ マニフェストまたはレジストリ上の (特別な) イメージ構成からキャッシュをインポートする
- `local`: 以前に`--cache-to`でエクスポートされたローカル ファイルからキャッシュをインポートする
- `gha`: GitHub リポジトリ内の 以前に`--cache-to`でエクスポートされたキャッシュからキャッシュをインポートする
- `s3`: S3 バケット内の 以前に`--cache-to`でエクスポートされたキャッシュからキャッシュをインポートする

尚、docker ドライバーは現在、レジストリからのビルド キャッシュのインポートのみをサポートしている

#### perplexity に質問した結果

`docker buildx build`コマンドでキャッシュを使用する際のパラメータの違いは、キャッシュの保存先と読み取り先によって異なる。
`local`と`gha`の主要な違いは、キャッシュの保存先と読み取り先であり、`local`はローカルファイルシステムを、`gha`は GitHub Actions のキャッシュストアを使用する。

- **local**: ローカルファイルシステム上でのキャッシュを利用する。キャッシュは指定されたディレクトリに保存され、次のビルド時に同じディレクトリから読み込まれる。

  これは、ローカルでビルドを行う際に有効。

  ```sh
  docker buildx build --push -t <registry>/<image> \
    --cache-to type=local,dest=path/to/local/dir[,parameters...] \
    --cache-from type=local,src=path/to/local/dir .
  ```

- **gha**: GitHub Actions のキャッシュを利用する。キャッシュは GitHub Actions のキャッシュストアに保存され、次のビルド時に同じストアから読み込まれる。

  これは、CI/CD パイプラインで GitHub Actions を使用する際に有効。
  scope

  ```sh
  docker buildx build --push -t <registry>/<image> \
    --cache-to type=gha[,parameters...] \
    --cache-from type=gha[,parameters...] .
  ```

- **registry**: Docker イメージリポジトリへのキャッシュを利用します。キャッシュは指定されたイメージリポジトリに保存され、次のビルド時に同じリポジトリから読み込まれます。

  これは、CI/CD パイプラインで Docker イメージリポジトリを使用する際に有効。

  ```sh
  docker buildx build --push -t <registry>/<image> \
    --cache-to type=registry,ref=<registry>/<cache-image>[,parameters...] \
    --cache-from type=registry,ref=<registry>/<cache-image>[,parameters...] .
  ```

#### GitHub Actions のキャッシュストア

[actions/cache](https://github.com/actions/cache)を使ってcacheする
