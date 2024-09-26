# Docker compose

docker compose cli `v2`より様々な機能が追加されている

## docker compose ファイル名

[Compose file](https://docs.docker.com/compose/compose-application-model/#the-compose-file)によると、

- compose.yaml (推奨)
- compose.yml
- docker-compose.yml
- docker-compose.yaml

## 依存関係の設定

- `service_started`: 依存するサービス開始まで待機。(ステータスは問わない)
- `service_healthy`: 依存するサービスが healthy になるまで待機 (他のサービスからのアクセスを受け付けられる状態)
  - これを使うには、`healthcheck`が必要となる
- `service_completed_successfully`: 依存するサービスが正常終了するまで待機

```yml
services:
  web:
    build: .
    depends_on:
      db:
        # 状態を細かく指定できる
        condition: service_healthy # DBは初期化処理等を考慮し、`service_healthy`を指定
      redis:
        condition: service_started #　redisは`service_started`で十分
      ports:
        - "8080:8080"
      environment:
        DATABASE_URL: postgres://user:password@db/mydatabase

  redis:
    image: redis

  db:
    image: postgres
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydatabase
    # DB container自身にhealthcheckを組み込む
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 3s
      timeout: 10s
      retries: 10
```

## Docker image 名やコンテナ名のプレフィックスをディレクトリ名から変更する

通常は `${ディレクトリ名}_${サービス名}`でイメージが作成されるが、compose.yaml のトップレベルに `name:` を記載することで変更でき、`${name}_${サービス名}`にイメージ名を変更可能

```yml
# sample-web になる
name: sample
services: ...
  web:
```

または、環境変数`COMPOSE_PROJECT_NAME`でプロジェクト名を指定することにより`${プロジェクト名}_${サービス名}`にイメージ名を変更可能
もしくは、`docker compose build --project ${project名}` でも可能

## profiles によるサービスのグループ化

[profiles](https://docs.docker.com/compose/profiles/)により、複数のサービスをまとめて起動・終了などをすることが可能

```yml
services:
  web:
    image: web

  mock-backend:
    image: backend
    profiles: ["dev"]
    depends_on:
      - db

  db:
    image: mysql
    profiles: ["dev"]

  phpmyadmin:
    image: phpmyadmin
    profiles: ["debug"]
    depends_on:
      - db
```

`dev`グループを起動

```sh
docker compose --profile dev up
```

## ファイル監視による自動更新

[Compose Watch](https://docs.docker.com/compose/file-watch/)という機能を使うことになる
3 モードあり、ファイル更新時の挙動が異なる

- Sync
  - ホスト側のファイル変更がコンテナ側に反映される
  - e.g. ホットリロード機能を内蔵しているサービス
- Rebuild
  - イメージをビルドしコンテナを入れ替える
  - e.g. package.json の依存するパッケージの変更など、イメージの再ビルドが必要な場合
- Sync + Restart
  - ファイル変更を反映し、コンテナをリスタートする
  - e.g. データベースの config 変更

```yml
services:
  web:
    build: .
    command: npm start
    develop:
      watch:
        - action: sync
          path: ./web
          target: /src/web
          ignore:
            - node_modules/
        - action: rebuild
          path: package.json
```

## ヘルスチェックの設定

これは`v1`でもできたが

```yml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost"]
  interval: 1m30s
  timeout: 10s
  retries: 3
  start_period: 40s
```

## build内の`target`

```yaml
postgresql:
  container_name: webfw-postgresql
  build:
    context: ./docker
    dockerfile: Dockerfile_pg
    target: "database"
```

ここで指定する`target`は、マルチステージビルドの`ステージ名`となる。

```dockerfile
#FROM イメージ名 AS ステージ名
FROM tytocare/node-base:20.17.0 AS base
```

## `/var/run/docker.sock`のマウントについて

```yaml
service1:
  ...
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
```

`/var/run/docker.sock:/var/run/docker.sock` という設定は、DockerコンテナにホストのDockerデーモンにアクセスするための方法を提供するために使用される。具体的には、Dockerのソケットファイル (`/var/run/docker.sock`) をコンテナ内にマウントすることを指す。

基本的に、Dockerデーモン（Dockerエンジン）はホストシステム上で動作し、`/var/run/docker.sock` というソケットファイルを介してAPIリクエストを受け付ける。Dockerを使用するための多くのツールやサービスは、このソケットファイルを介してDockerデーモンと通信する。

### この設定が必要となる典型的なケース

1. **Docker in Docker (DinD)**:
   コンテナ内でDockerのコマンドを実行し、他のコンテナを管理する必要がある場合。この設定があると、コンテナ内部からホストのDockerデーモンに直接コマンドを送信できる。

2. **CI/CD パイプライン**:
   JenkinsやGitLab CIなどのCI/CDツールは、ジョブを実行するためにDockerコンテナ内で動作することがある。これらのジョブが他のコンテナを起動したり、管理したりする必要がある場合にこの設定を使うことが多い。

3. **開発ツールやスクリプト**:
   一部の開発ツールやスクリプトがコンテナ内で実行されるが、ホストシステム上のDockerコンテナを操作する必要がある場合。

### セキュリティに関する注意

この設定により、コンテナはホストのDockerデーモンに完全なアクセス権を持つことになる。つまり、この設定を使うと、コンテナ内部からホストシステムの全てのコンテナを制御したり、新たなコンテナを起動することが可能。
これにはセキュリティリスクが伴う。もしコンテナ内のアプリケーションが攻撃を受けたり、悪意のあるコードが実行された場合、その攻撃者はホスト全体のDocker環境を制御できてしまう。そのため、この設定を使用する際には信頼できる環境でのみ行う、もしくは厳密なセキュリティ対策を講じることが推奨される。

## References

- [個人的 docker compose おすすめ tips 9 選](https://future-architect.github.io/articles/20240620a/)
