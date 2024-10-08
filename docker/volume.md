# Docker Volume のマウント

Docker では、コンテナ内に外部のディスク領域をマウントすることができる。この機能は、データの保持や共有、設定のカスタマイズなどに利用される。

## マウントされる領域

### 1. ボリューム (Volumes)

ボリュームは Docker が管理する領域で、ホストファイルシステムとは独立している

- データが永続化されるため、コンテナを削除してもデータは残る。
- Docker の管理により、異なるコンテナ間でデータを簡単に共有できる。
- `/var/lib/docker/volumes` 内に保存される（デフォルト設定の場合）。

#### ボリュームの作成と利用例

```sh
# ボリュームの作成
docker volume create my-volume

# ボリュームを使用してコンテナを実行
docker run -d -v my-volume:/data my-image
```

### 2. バインドマウント (Bind Mounts)

バインドマウントはホストファイルシステムに直接アクセスする

- ホスト上の任意のディレクトリやファイルをコンテナ内にマウントできる。
- コンテナ停止後もデータはホスト上に存在し続ける。
- パスの論理性やセキュリティに注意が必要。

#### バインドマウントの利用例

```sh
docker run -d -v /path/on/host:/path/in/container my-image
```

### 3. テンポラリーファイルシステム (tmpfs)

`tmpfs` はコンテナのライフサイクル中のみ存在する一時的なファイルシステム

- メモリ上にデータを保持する。
- データは揮発性で、コンテナが停止すると失われる。
- 高速な読み書きを必要とする一時データに適している。

#### tmpfs の利用例

```sh
docker run -d --tmpfs /path/in/container my-image
```

## 各マウント方法の使い分け

- **ボリューム**は、データ永続化や異なるコンテナ間でのデータ共有が必要な場合。
- **バインドマウント**は、ホストとの連携が強く必要で動的なファイル変更や開発環境構築が目的の場合。
- **tmpfs**は、高速な一時ファイルの読み書きが必要な場合（例：キャッシング）。

## Docker Compose でのマウント設定

```yaml

services:
  web:
    image: my-image
    volumes:
      - my-volume:/data
      - /path/on/host:/path/in/container
      - type: tmpfs, target: /path/in/container

volumes:
  my-volume:
```

## Volume 関連コマンド

### 1. ボリュームの作成

指定した名前で新しいボリュームを作成する

```sh
docker volume create my-volume
```

### 2. ボリュームの一覧表示

すべての Docker ボリュームを一覧表示する

```sh
docker volume ls
```

### 3. ボリュームの詳細確認

特定のボリュームの詳細情報を表示する

```sh
docker volume inspect my-volume
```

### 4. ボリュームの削除

特定のボリュームを削除する

```sh
docker volume rm my-volume
```

#### 一括削除

未使用のボリュームを一括削除することもできる

```sh
docker volume prune
```

## Volume の中身を確認する

### 一時コンテナを使ってボリュームの中身を確認する

1. **一時コンテナを起動する**：

    ```sh
    docker run --rm -it -v my-volume:/data alpine sh
    ```

    - `--rm`：コンテナが停止したときに自動的に削除されるオプション。
    - `-it`：インタラクティブモードでシェルを起動するオプション。
    - `-v my-volume:/data`：作成したボリューム `my-volume` を一時コンテナの `/data` ディレクトリにマウントするオプション。
    - `alpine sh`：`alpine` イメージを使用し、シェル（`sh`）を起動する。

2. **コンテナ内でボリュームの内容を確認する**：

    コンテナ内のシェルが立ち上がるので、以下のようにコマンドを入力して確認する。

    ```sh
    ls -l /data
    cat /data/yourfile.txt  # 必要に応じてファイル内容を表示
    ```

### 既存のコンテナを利用して確認する

1. **稼働中のコンテナを一覧表示する**：

    ```sh
    docker ps
    ```

2. **コンテナにシェルアクセスする**：

    例えば、対象のコンテナ ID が `123abc` の場合

    ```sh
    docker exec -it 123abc sh  # または bash
    ```

3. **ボリュームの中身を確認する**：

    マウントポイントに移動して内容を確認する。

    ```sh
    ls -l /path/to/mountpoint
    ```
