# Cache

## ビルドキャッシュの仕組み

```dockerfile
# syntax=docker/dockerfile:1
FROM ubuntu:latest

RUN apt-get update && apt-get install -y build-essentials
COPY main.c Makefile /src/
WORKDIR /src/
RUN make build
```

この Dockerfile 内の各命令は、最終イメージ内のレイヤーに変換される。イメージ レイヤーはスタックとして考えることができ、各レイヤーは前のレイヤーの上にさらにコンテンツを追加する。
レイヤーが変更されるたびに、そのレイヤーを再構築する必要がある。たとえば、main.cファイル内のプログラムに変更を加えたとする。この変更後、COPYその変更をイメージに反映するには、コマンドを再度実行する必要がある。つまり、Docker はこのレイヤーのキャッシュを無効にする。
`レイヤーが変更されると、それ以降のすべてのレイヤーも影響を受ける`。コマンドを含むレイヤーがCOPY無効になると、それ以降のすべてのレイヤーも再度実行する必要がある。

## ビルドでのキャッシュ使用を最適化する

ビルド キャッシュを最適化し、ビルド プロセスを高速化するために使用できるいくつかの手法は以下の通り

1. **レイヤーの順序付け**: Dockerfile 内のコマンドを論理的な順序に並べると、不要なキャッシュの無効化を回避できる。
2. **コンテキストを小さく保つ**: コンテキストとは、ビルド命令を処理するためにビルダーに送信されるファイルとディレクトリのセット。コンテキストをできるだけ小さく保つと、ビルダーに送信する必要のあるデータの量が減り、キャッシュが無効化される可能性が低くなる。
3. **バインド マウントを使用する**: バインド マウントを使用すると、ホスト マシンからビルド コンテナーにファイルまたはディレクトリをマウントできる。バインド マウントを使用すると、ビルド プロセスを遅くする可能性のある、イメージ内の不要なレイヤーを回避できる。
4. **キャッシュ マウントの使用**: キャッシュ マウントを使用すると、ビルド中に使用する永続的なパッケージ キャッシュを指定できる。永続的なキャッシュは、ビルド手順、特にパッケージ マネージャーを使用してパッケージをインストールする手順を高速化するのに役立つ。パッケージの永続的なキャッシュがあると、レイヤーを再構築した場合でも、新しいパッケージまたは変更されたパッケージのみがダウンロードされる。
5. **外部キャッシュを使用する**: 外部キャッシュを使用すると、ビルド キャッシュをリモートの場所に保存できり。外部キャッシュ イメージは、複数のビルド間や異なる環境間で共有できる。

### 1. レイヤーを並べ替える

修正前

```dockerfile
# syntax=docker/dockerfile:1
FROM node
WORKDIR /app
COPY . .          # Copy over all files in the current directory
RUN npm install   # Install dependencies
RUN npm build     # Run build
```

修正後

```dockerfile
# syntax=docker/dockerfile:1
FROM node
WORKDIR /app
COPY package.json yarn.lock .    # Copy package management files
RUN npm install                  # Install dependencies
COPY . .                         # Copy over project files
RUN npm build                    # Run build
```

### 2. コンテキストを小さく保つ

コンテキストに不要なファイルが含まれていないことを確認する最も簡単な方法は、`.dockerignore`ファイルをビルド コンテキストのルートに作成すること

### 3. バインドマウントを使用する

バインド マウントを使用すると、ホスト マシンからコンテナーにファイルまたはディレクトリをマウントできる。
マウントされたファイルは最終イメージまたはビルド キャッシュには保存されない。go buildコマンドの出力のみが残る。
ビルド コンテキストが大きめで、Goなどアーティファクトの生成にのみ使用される場合は、バインド マウントを使用して、アーティファクトの生成に必要なソース コードをビルドに一時的にマウントする方がよい。

#### バインドマウントの注意点

- バインド マウントは、デフォルトでは読み取り専用
- マウントされたファイルは最終イメージには保存されない
- ターゲットディレクトリが空でない場合、マウントされたファイルによってターゲットディレクトリの内容が隠される
  - RUN命令の実行後、元の内容が復元される

### 4. キャッシュマウントを使用する

キャッシュ マウントは、ビルド中に使用される永続的なキャッシュの場所を指定する方法。キャッシュはビルド間で累積されるため、キャッシュを複数回読み書きできる。この永続的なキャッシュにより、レイヤーを再構築する必要がある場合でも、新しいパッケージまたは変更されたパッケージのみをダウンロードできる。変更されていないパッケージは、キャッシュ マウントから再利用される。

キャッシュ マウントの指定方法は、使用しているビルド ツールによって異なるので注意が必要

```go
RUN --mount=type=cache,target=/go/pkg/mod \
    go build -o /app/hello
```

```go
RUN --mount=type=cache,target=/go/pkg/mod/,sharing=locked \
    --mount=type=bind,source=go.sum,target=go.sum \
    --mount=type=bind,source=go.mod,target=go.mod \
    go mod download
RUN --mount=type=cache,target=/go/pkg/mod/ \
    --mount=type=bind,target=. \
    go build -o /app/hello
```

#### `sharing=locked`について

たとえば、Apt はデータへの排他的アクセスを必要とするため、キャッシュは この`sharing=locked`オプションを使用して、同じキャッシュマウントを使用する並列ビルドが互いに待機し、同時に同じキャッシュ ファイルにアクセスしないようにする。

#### 動的パラメータを使っている場合

レイヤー単位でのキャッシュが効かなくなる

```sh
ARG COMMIT_ID
ENV ARCH="arm64"
RUN --mount=type=cache,target=/go/pkg/mod/ \
    --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=bind,target=. \
    GOOS=linux GOARCH=${ARCH} CGO_ENABLED=0 \
    go build -trimpath -ldflags="-s -w -X main.CommitID=${COMMIT_ID}" -o /bin/line_batch ./cmd/line_batch/
```

#### WIP: キャッシュマウントを使った場合、どこにcacheは作られるのか？

ホストマシンのファイルシステム上に保存されるとのこと。
Github Actionsの環境では、Linuxランナーであれば、`/home/runner/work/_temp/_github_home/docker/volumes/` など

わざわざ、[buildkit-cache-dance](https://github.com/reproducible-containers/buildkit-cache-dance)というGithub Actionが存在する。
[GitHub Actions 上での Go の Docker ビルドを高速化する](https://zenn.dev/cybozu_ept/articles/productivity-weekly-20240515)によると、
`--mount=type=cache オプションを利用すると Docker のビルド時にキャッシュをローカルに保存することが可能`とのことだが、残念ながら GitHub Actions はローカルマシンと異なりビルドのたびに毎回新しいマシンが割り当てられるため RUN --mount=type=cache のキャッシュが残っていない、とある。

### 5. 外部キャッシュを使用する

ビルドのデフォルトのキャッシュ ストレージは、使用しているビルダー (BuildKit インスタンス) の内部にある。各ビルダーは独自のキャッシュ ストレージを使用する。異なるビルダー間を切り替えると、キャッシュはビルダー間で共有されない。外部キャッシュを使用すると、キャッシュ データをプッシュおよびプルするためのリモートの場所を定義できる。

外部キャッシュは、ビルダーが一時的なものであることが多く、ビルド時間が貴重な CI/CD パイプライン上で特に役立つ。ビルド間でキャッシュを再利用すると、ビルド プロセスが大幅に高速化され、コストが削減される。`ローカル開発環境で同じキャッシュを利用することもできる`。

#### 外部キャッシュを使用する

`--cache-to`オプション及び、`--cache-from`オプションを利用し、`docker buildx build`コマンドを実行する。

- `--cache-to`: ビルド キャッシュを指定された場所にエクスポートする
- `--cache-from`: ビルドで使用するリモート キャッシュを指定する

#### Github Actionsを使ったworkflowの例

```yml
name: ci

on:
  push:

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ vars.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Build and push
        uses: docker/build-push-action@v6
        with:
          push: true
          tags: user/app:latest
          cache-from: type=registry,ref=user/app:buildcache
          cache-to: type=registry,ref=user/app:buildcache,mode=max
```

```sh
docker buildx build --cache-from type=registry,ref=user/app:buildcache .
```

[GitHub Actions cache](https://docs.docker.com/build/cache/backends/gha/)

## References

- [Docker build cache](https://docs.docker.com/build/cache/)
  - [Cache storage backends: GitHub Actions cache](https://docs.docker.com/build/cache/backends/gha/)
  - [Optimize cache usage in builds](https://docs.docker.com/build/cache/optimize/)
- [GitHub Actionsのキャッシュを活用してGoのビルド時間を短縮してみる](https://www.cloudbuilders.jp/articles/5660/)
- [GitHub Actions 上での Go の Docker ビルドを高速化する](https://zenn.dev/cybozu_ept/articles/productivity-weekly-20240515)
