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

Docker Desktop `4.33`からの機能で有償専用の機能

```sh
Docker Debug requires a Pro, Teams, or Business Subcription.
Learn more at https://docs.docker.com/subscription/details/
```

- [docker buildx debug](https://docs.docker.com/reference/cli/docker/buildx/debug/)
- [docker buildx debug build](https://docs.docker.com/reference/cli/docker/buildx/debug/build/)
- [Docker Desktop 4.33: Docker Debug と Docker Build Checks の GA リリースと、強化された構成整合性チェック](https://www.docker.com/ja-jp/blog/docker-desktop-4-33/)

[Docker ビルド チェックの概要: ベスト プラクティスを使用した Dockerfile の最適化](https://www.docker.com/ja-jp/blog/introducing-docker-build-checks/)に記載のある `docker --debug build` が使えるようになる？
