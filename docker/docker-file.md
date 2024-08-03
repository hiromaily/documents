# Dockerfile

## Docker Build チェック

Docker Desktop `4.33`からの機能で、Dockerfile の構文チェックだけでなく最適化などもガイドする`linter`の役割を果たす

```sh
docker build -f ./docker/Dockerfile_rust . --check
```

- [Docker ビルド チェックの概要: ベスト プラクティスを使用した Dockerfile の最適化](https://www.docker.com/ja-jp/blog/introducing-docker-build-checks/)

## マルチステージ ビルド

- [マルチステージ ビルドを使う](https://docs.docker.jp/develop/develop-images/multistage-build.html)

## [Mounts](https://docs.docker.com/build/guide/mounts/)

docker build 時の設定

- 2 種類の mounts
  - cache mounts
    - ビルド中に使用される永続的なパッケージキャッシュを指定できる
    - ビルド手順、特にパッケージ マネージャーを使用してパッケージをインストールする手順を高速化するのに役立つ
  - [bind mount](https://docs.docker.jp/storage/bind-mounts.html)
    - ホストからコンテナに直接ファイルを利用できるようになる
    - この変更により、追加の COPY 命令 (およびレイヤー) がまったく不要になる

### cache mounts

- [sample code](https://github.com/hiromaily/docker-tips/tree/main/cache-mount)

```dockerfile
# syntax=docker/dockerfile:1
FROM golang:1.21-alpine AS base
WORKDIR /src
COPY go.mod go.sum .
# 旧来の方法
# RUN go mod download
# cache mountを使う
RUN --mount=type=cache,target=/go/pkg/mod/ \
    go mod download -x
COPY . .

# Step 2
FROM base AS build-client
# RUN go build -o /bin/client ./cmd/client
RUN --mount=type=cache,target=/go/pkg/mod/ \
    go build -o /bin/client ./cmd/client

# Step 3
FROM base AS build-server
# RUN go build -o /bin/server ./cmd/server
RUN --mount=type=cache,target=/go/pkg/mod/ \
    go build -o /bin/server ./cmd/server

# Step 4 A
FROM scratch AS client
COPY --from=build-client /bin/client /bin/
ENTRYPOINT [ "/bin/client" ]

# Step 4 B
FROM scratch AS server
COPY --from=build-server /bin/server /bin/
ENTRYPOINT [ "/bin/server" ]
```

#### cache mount からの rebuild

`--target`オプションで Stage を指定できる

```sh
docker build --target=client --progress=plain . 2> log1.txt
```

### bind mounts

```dockerfile
# syntax=docker/dockerfile:1
FROM golang:1.21-alpine AS base
WORKDIR /src

# COPY go.mod go.sum .
RUN --mount=type=cache,target=/go/pkg/mod/ \
    --mount=type=bind,source=go.sum,target=go.sum \
    --mount=type=bind,source=go.mod,target=go.mod \
    go mod download -x

# COPY . .

FROM base AS build-client
RUN --mount=type=cache,target=/go/pkg/mod/ \
--mount=type=bind,target=. \
    go build -o /bin/client ./cmd/client

FROM base AS build-server
RUN --mount=type=cache,target=/go/pkg/mod/ \
--mount=type=bind,target=. \
    go build -o /bin/server ./cmd/server

FROM scratch AS client
COPY --from=build-client /bin/client /bin/
ENTRYPOINT [ "/bin/client" ]

FROM scratch AS server
COPY --from=build-server /bin/server /bin/
ENTRYPOINT [ "/bin/server" ]
```

## Directives

### `ENV`

環境変数はキーと値のペア

```Dockerfile
ENV <key> <value>
ENV <key>=<value> <key=value>

ENV PATH=$PATH:/usr/local/app/bin/ VERSION=1.0.0
```

### `ARG`

`docker build`コマンドでビルド時にビルダに渡す変数を定義するために使用される。
`ENV` 変数と異なり、`ARG` 変数は実行中のコンテナからはアクセスできない。 これらはビルドプロセス中にのみ利用可能

```Dockerfile
ARG <varname>

ARG USER
ARG VERSION

# default値を持つこともできる
ARG USER=TestUser
ARG VERSION=1.0.0

# example
ARG TAG=latest
FROM ubuntu:$TAG
LABEL maintainer=ananalogguyinadigitalworld@example.com
ENV ENVIRONMENT=dev APP_DIR=/usr/local/app/bin
CMD ["env"]
```

ビルド例

```sh
docker image build -t env-arg --build-arg TAG=23.10 .
```

### `WORKDIR`

カレント作業ディレクトリを設定する。指定されたディレクトリがイメージ内に存在しない場合、Docker はビルドプロセス中にそれを作成する。
WORKDIR ディレクティブは、`mkdir` と `cd` コマンドの機能を Unix ライクに組み合わせたもの。

```Dockerfile
WORKDIR /path/to/workdir

# example
# 最終的に、workdirは、`/one/two/three/drink` となる
WORKDIR /one
WORKDIR two
WORKDIR three
WORKDIR drink
```

### COPY

ローカルファイルシステムからビルドするイメージにコピーするファイルやディレクトリを指定する。

<source> は、ビルド コンテキストからの相対パスで、ローカル ファイル システム上のファイルまたはディレクトリへのパスを指定。

```Dockerfile
COPY <source> <destination>

COPY index.html /var/www/html/index.html

# ワイルドカードを使って、指定されたパターンにマッチするすべてのファイルをコピーすることもできる
COPY *.html /var/www/html/

# --chown フラグを指定すると、Dockerイメージ内でコピーされたファイルのユーザーとグループの所有権を設定することができる
COPY --chown=myuser:mygroup *.html /var/www/html/
```

### ADD

COPY ディレクティブに似ているが、追加機能がある。

```Dockerfile
ADD <source> <destination>

# ローカルファイルシステムから
ADD index.html /var/www/html/index.html

# URLを指定することもできる
ADD http://example.com/test-data.csv /tmp/test-data.csv

# ある種の圧縮アーカイブからの 自動抽出機能も含んでいる
# <source> が圧縮されたアーカイブファイルの場合、Dockerは自動的にその内容をDockerイメージファイルシステム内の <destination> に展開する
ADD myapp.tar.gz /opt/myapp/
```

### USER

Docker では、デフォルトでコンテナはコンテナ環境内で広範な権限を持つ`root`ユーザで実行される。
セキュリティリスクを軽減するために、Docker では USER ディレクティブを使用して、非 root ユーザーを指定することができる。

```Dockerfile
USER <user>
USER <user>:<group>

# example
FROM ubuntu:latest
RUN apt-get update && apt-get upgrade
RUN apt-get install apache2 -y
USER www-data
# current user is `www-data`
CMD ["whoami"]
```

### VOLUME

ボリュームは、コンテナのライフサイクルとは無関係にデータを`永続化する`方法を提供する。ボリュームは Docker コンテナとホストマシン間のブリッジとして機能し、コンテナが停止、削除、交換されてもボリューム内に保存されたデータが持続することを保証する。
Dockerfile で `VOLUME` ディレクティブを使用してボリュームを定義すると、Docker はコンテナのファイルシステム内に管理ディレクトリを作成する。 このディレクトリはボリュームのマウントポイントとして機能する。 重要なのは、Docker はホストマシン上にも対応するディレクトリを確立し、そこにボリュームの実際のデータを格納する。 このマッピングにより、コンテナ内からボリューム内のファイルに加えられた変更は、ホストマシン上のマッピングされたディレクトリと即座に同期される。

Docker のボリュームは、`名前付きボリューム`や`ホストマウントされたボリューム`など、様々なタイプをサポートしている。 `名前付きボリューム`は Docker によって作成・管理され、ボリュームのライフサイクルやストレージ管理をより柔軟に制御できる。 一方、`ホストマウントされたボリューム`では、ホストのファイルシステムからコンテナにディレクトリを直接マウントすることができ、ホストのリソースに簡単にアクセスできる。

VOLUME ディレクティブは、一般的に JSON 配列をパラメータとして受け取る

```Dockerfile
VOLUME ["path/to/volume"]

# multiple
VOLUME /path/to/volume1 /path/to/volume2
```

### EXPOSE

コンテナが実行中に特定のポートをリッスンすることを Docker に示すためのもの。 `この宣言は主に情報提供であり、実際にポートをホストシステムに公開したり、デフォルトでコンテナの外からアクセスできるようにしたりはしない`。 その代わりに、Docker 環境内でコンテナ間通信やネットワークサービスに使用するポートを文書化する。

EXPOSE ディレクティブは TCP と UDP の両方のプロトコルをサポートしており、 さまざまなネットワーク要件に対してポートの公開方法を柔軟に変更することができる。 このディレクティブは、コンテナ実行時に使用される -p または -P オプションの前段階であり、これらの公開ポートをホストマシン上のポートに実際にマッピングし、必要に応じて外部からのアクセスを可能にする。

```Dockerfile
EXPOSE <port>
```

### HEALTHCHECK

Docker コンテナ内で実行されているアプリケーションが適切に機能しているかどうかを検証する手段を提供する。
Docker の HEALTHCHECK ディレクティブにより、開発者はコンテナの状態を定期的に検査し、その健全性を報告するカスタムヘルスチェックを定義できる。 このディレクティブはプロアクティブな監視を保証し、Docker オーケストレーションツールが健全性の状態に基づいてコンテナのライフサイクル管理について情報に基づいた決定を下すのを助ける。
HEALTHCHECK ディレクティブは、Dockerfile 内に一つしか存在できない。複数の HEALTHCHECK ディレクティブがある場合は、最後のものだけが有効になります。

```Dockerfile
# 0 は健全なコンテナを意味し、1 は不健全なコンテナを意味する
HEALTHCHECK CMD curl -f http://localhost/ || exit 1

# example
HEALTHCHECK \
    --interval=1m \
    --timeout=2s \
    --start-period=2m \
    --retries=3 \
    CMD curl -f http://localhost/ || exit 1
```

### ONBUILD

後続のイメージビルドのための再利用可能なベースイメージの作成を容易にする。 これによって開発者は、他の Docker イメージが現在のイメージをベースとして使用する場合にのみ起動する命令を定義することができる。 例えば、アプリケーションの実行に必要な`前提条件`や設定をすべて含む Docker イメージを構築することができる。
この `前提条件` イメージに ONBUILD ディレクティブを適用することで、そのイメージが別の Dockerfile の親として採用されるまで、特定の命令を遅延させることができる。 これらの延期された命令は、現在の Dockerfile のビルドプロセス中には実行されず、代わりに子イメージのビルド時に継承されて実行される。 このアプローチは環境のセットアッププロセスを合理化し、ベースイメージから派生した複数のプロジェクトやアプリケーションに共通の依存関係や設定が一貫して適用されるようにする。

```Dockerfile
ONBUILD ENTRYPOINT ["echo", "Running an ONBUILD Directive"]

# example
# for base image
FROM ubuntu:latest
RUN apt-get update && apt-get upgrade
RUN apt-get install apache2 -y
ONBUILD COPY *.html /var/www/html
EXPOSE 80
ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]

# 上記のDockerfileから出来上がったImageをFROMで読み込んで作成するDockerfileは、
# `ONBUILD`で指定した、`COPY *.html /var/www/html`が暗黙的に実行されることになる
```

## References

- [高度な Dockerfile ディレクティブ](https://dev.to/kalkwst/advanced-dockerfile-directives-193f)
