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

## References

- [個人的 docker compose おすすめ tips 9 選](https://future-architect.github.io/articles/20240620a/)
