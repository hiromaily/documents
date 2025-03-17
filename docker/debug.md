# Debug

## image の build 時の log を表示する

### `--progress=plain` オプション

```sh
docker compose build --progress=plain actix-server
```

このとき、Dockerfile 内で、`RUN ls -la`によって実行ディレクトリの状態を確認できる

## Dockerfile linter 相当の`--check` オプション

```sh
docker build -f ./docker/Dockerfile_rust . --check
```

- `compose build` では利用できない

## WIP: `docker scout`

[docker scout](https://www.docker.com/ja-jp/products/docker-scout/)はDockerの開発ワークフローのセキュリティー面も含めた改善を目的とするサービスで、分析、修正、評価を行う。
無料プランもあるが、有償サービスとなる。

`docker build`後に`View a summary of image vulnerabilities and recommendations` と表示される

```sh
docker scout quickview
```

## `docker debug`

`docker debug`は、任意のコンテナやイメージにシェルを取得するためのCLIコマンド。これは、`docker exec`を使用したデバッグの代替手段として機能する。特に、スリムイメージやツールが削除されたコンテナのデバッグに役立つ。Docker Desktop `4.33`からの機能で有償専用の機能

### `docker debug`の使用方法

```sh
docker debug [OPTIONS] {CONTAINER|IMAGE}
```

### `docker debug`の特徴

- **シェルの取得**: シェルが含まれていないコンテナやイメージでもデバッグシェルを取得できる。
- **イメージの変更なし**: `docker debug`を使用しても、イメージ自体は変更されない。
- **ツールボックス**: 標準的なLinuxツール（vim、nano、htop、curlなど）がプリインストールされたツールボックスを提供する。

### `docker debug`のカスタムツール

- `install [tool1] [tool2]`: Nixパッケージを追加する。
- `uninstall [tool1] [tool2]`: Nixパッケージをアンインストールする。
- `entrypoint`: エントリーポイントを表示、リント、または実行する。
- `builtins`: カスタムビルトインツールを表示する。

### `docker debug`のオプション

| オプション      | デフォルト | 説明                                                                         |
| --------------- | ---------- | ---------------------------------------------------------------------------- |
| `--shell`       | auto       | 使用するシェルを選択します（bash、fish、zshなど）。                          |
| `-c, --command` |            | インタラクティブセッションを開始する代わりに指定されたコマンドを評価します。 |
| `--host`        |            | 接続するデーモンDockerソケットを指定します。                                 |

### `docker debug`の使用例

1. **シェルのないコンテナのデバッグ**:

   ```bash
   docker run --name my-app hello-world
   docker debug my-app
   ```

2. **スリムイメージのデバッグ**:

   ```bash
   docker debug hello-world
   ```

3. **実行中のコンテナのファイルを変更**:

   ```bash
   docker run -d --name web-app -p 8080:80 nginx
   docker debug web-app
   vim /usr/share/nginx/html/index.html
   ```

4. **ツールの管理**:

   ```bash
   docker debug nginx
   install nmap
   ```

5. **リモートデバッグ**:

   ```bash
   docker debug --host ssh://root@example.org my-container
   ```

### `docker debug`の注意点

- 停止したコンテナやイメージに対する変更は、シェルを離れるとすべて破棄される。
- 実行中または一時停止中のコンテナに対するファイルシステムの変更は、コンテナに直接表示される。

このコマンドは、特にスリムイメージのデバッグにおいて非常に便利で、開発者が効率的に作業できるように設計されている。

### Ref: docker debug

- [docker buildx debug](https://docs.docker.com/reference/cli/docker/buildx/debug/)
- [docker buildx debug build](https://docs.docker.com/reference/cli/docker/buildx/debug/build/)
- [Docker Desktop 4.33: Docker Debug と Docker Build Checks の GA リリースと、強化された構成整合性チェック](https://www.docker.com/ja-jp/blog/docker-desktop-4-33/)

[Docker ビルド チェックの概要: ベスト プラクティスを使用した Dockerfile の最適化](https://www.docker.com/ja-jp/blog/introducing-docker-build-checks/)に記載のある `docker --debug build` が使えるようになる？
