# Redis

メモリ上で動作するキーバリューストア型のデータベース

## Version

### `Redis 7`

- 最新安定バージョン
- パフォーマンス、スケーリング、コマンド内省、ACL の改善
- より優れた監視ツールなどの新機能

### `Redis 6`

- `マルチスレッド機能`
- `Role-Based Access Control (RBAC) 機能`
  - ACL(アクセス制御リスト)
- SSL サポート
- セキュリティ向上のための 、[クライアントサイドのキャッシュ](https://redis.io/docs/latest/develop/use/client-side-caching/)
- Redis シリアライゼーションプロトコルの新バージョンである `RESP3` が導入

### `Redis 5`

- `ストリーム`を導入。これは、リアルタイムのデータを管理するためのログデータ構造
- `クラスタリング機能`が改善され、`Redis モジュール`が導入。

## 概要

### 高速性

インメモリデータベースであり、データをメモリに格納するため、高速な読み書きアクセスが可能。また、Redis は非同期でディスクへの書き込みを行うこともできる。

### データ構造のサポート

さまざまなデータ構造をサポートしており、キーと値のペアの保存だけでなく、`文字列`、`リスト`、`セット`、`ソート済みセット`、`ハッシュ`などのデータ型を使用することができる。これにより、データの柔軟な操作や高度なデータ構造の表現が可能となる。

### 持続性とレプリケーション

ディスクにデータを`永続化`することもサポートしており、クラッシュや再起動後にもデータを復元することができる。また、`マスターとスレーブのレプリケーション機能`も提供しており、データの冗長性と可用性を高めることができる。
具体的には、マスターノードのデータを複数のスレーブノードに複製することで、高可用性と負荷分散が可能になる。

#### Redis Sentinel による高可用性

監視、通知、自動フェイルオーバー機能を持つ。レプリケーションを構成した Redis のマスター障害時に、フェイルオーバーが可能になる。

### パフォーマンスとスケーラビリティ

単一スレッドのアーキテクチャで動作し、非常に高速な処理速度を提供する。また、Redis クラスタリングにより、`データの水平スケーリング`も可能。

### キャッシュやセッションストアとしての利用

キャッシュやセッションストアとして広く利用されている。データをメモリに保持するため、データベースや外部システムへのアクセスを削減し、高速なレスポンスタイムを実現する。

### モジュール

Redis モジュールは、新しいデータタイプ、コマンド、機能 (e.g. `RedisGraph`、`RedisJSON`、`RedisTimeSeries`)を追加することで、Redis の機能を拡張できる

## ユースケース

- cache
- session 管理
- リアルタイム分析
- メッセージキュー
- リーダーボード (トーナメントで上位のプレーヤーの名前とスコアを載せるボード)

### インメモリデータベース

データをメモリに格納するインメモリデータベース。これにより、データの読み書きが高速に行われ、`リアルタイムな処理`や`高負荷なアプリケーション`に適している

### キャッシュ

インメモリ性質と高速性を活かし、データベースや外部システムへのクエリや処理結果をキャッシュとして利用することができる。これにより、データベースへの負荷を軽減し、アプリケーションのレスポンスタイムを向上させることができる。

## データ構造と主なデータ型

### 文字列（Strings）

シンプルな Key と Value のペアを保存する。文字列型は最も基本的なデータ型であり、任意のバイナリデータを格納できる。

### リスト（Lists）

`順序を持った要素のリスト`を保存する。リスト型は追加や削除、インデックスを使用したアクセスが可能であり、`キュー`や`スタック`などに利用される。

### セット（Sets）

`重複のない要素の集合`を保存する。セット型は`集合演算`や`メンバーシップの判定`に効果的であり、共通の要素や差分を取得することができる。

### ソート済みセット（Sorted Sets）

`セット型の要素`に`スコアを関連付けて`保存する。`スコアに基づいたソート`や`範囲検索`が可能であり、`ランキング`や`優先度付け`などに使用される。

### ハッシュ（Hashes）

フィールドと値のペアを保存します。ハッシュ型はオブジェクトや`連想配列のような構造を表現`でき、フィールドレベルでの追加や削除、値の取得が可能。

### ビットマップおよびビットフィールド (Bitmaps and Bitfields)

バイナリデータとしての文字列の操作

### HyperLogLogs

ユニークなアイテムをカウントするための確率的なデータ構造

### ストリーム (Streams)

リアルタイムデータを処理するためのログのようなデータ構造

## Client CLI (redis-cli) とコマンド

- キーの追加（SET コマンド）
  - 指定したキーに値をセットする
  - `SET key value`
- キーの削除（DEL コマンド）
  - 指定したキーとその値を削除する
  - `DEL key`
- キーの取得（GET コマンド）
  - 指定したキーに関連付けられた値を取得する
  - `GET key`
- キーの更新（SET コマンド）
  - 指定したキーの値を更新する。既存のキーがない場合は新しいキーが作成される
  - `SET key value`

### キーの有効期限の設定と管理

- キーの有効期限の設定（EXPIRE コマンド）:
  - 指定したキーに対して有効期限を設定する。有効期限が経過すると、キーとその値は自動的に削除される
  - `EXPIRE key seconds`
- キーの有効期限の確認（TTL コマンド）:
  - 指定したキーの有効期限までの残り秒数を取得する
  - `TTL key`
- キーの有効期限の解除（PERSIST コマンド）:
  - 指定したキーの有効期限を解除する。キーは永続的に保持される
  - `PERSIST key`

### キーのパターンマッチングと検索

- キーのパターンマッチング（KEYS コマンド）:
  - 指定したパターンに一致するキーを検索する。ワイルドカードを使用してパターンを指定できる
  - `KEYS pattern`
- キーの検索と一覧取得（SCAN コマンド）:
  - キーの一覧を取得。SCAN コマンドは大規模なデータセットに対して効率的に動作する
  - `SCAN cursor [MATCH pattern] [COUNT count]`

### 文字列型のデータの操作と利用例

- 文字列型のデータの設定（SET コマンド）:
  - 上記のコマンドを使用して、指定したキーに対して文字列型の値を設定する
  - `SET key value`
- 文字列型のデータの取得（GET コマンド）:
  - 指定したキーに関連付けられた文字列型の値を取得する
  - `GET key`

### リスト型のデータの操作と利用例

- リスト型のデータの追加（LPUSH コマンド）:
  - 指定したキーのリストの先頭に要素を追加する
  - `LPUSH key value1 value2 ...`
- リスト型のデータの取得（LRANGE コマンド）:
  - 指定したキーのリストから範囲指定で要素を取得する
  - `LRANGE key start stop`

### セット型とソート済みセット型のデータの操作と利用例

- セット型のデータへの要素の追加（SADD コマンド）:
  - 上記のコマンドを使用して、指定したキーのセットに要素を追加します。
  - `SADD key member1 member2 ...`
- セット型のデータの取得（SMEMBERS コマンド）:
  - 指定したキーのセットに含まれるすべての要素を取得する
  - `SMEMBERS key`
- ソート済みセット型のデータへの要素の追加とスコアの設定（ZADD コマンド）:
  - 指定したキーのソート済みセットに要素とスコアを追加する
  - `ZADD key score1 member1 score2 member2 ...`
- ソート済みセット型のデータの取得（ZRANGE コマンド）:
  - 指定したキーのソート済みセットから範囲指定で要素を取得する
  - `ZRANGE key start stop`

### ハッシュ型のデータの操作と利用例

- ハッシュ型のデータの設定（HSET コマンド）:
  - 上記のコマンドを使用して、指定したキーのハッシュにフィールドと値を設定します。
  - `HSET key field value`
- ハッシュ型のデータの取得（HGET コマンド）:
  - 指定したキーのハッシュから指定したフィールドの値を取得する
  - `HGET key field`

## Redis のパフォーマンスチューニング

### Redis の設定とチューニングの基本

#### Redis 設定ファイルの編集

Redis の設定ファイル(`redis.conf`)を編集し、パフォーマンスに関連する設定を調整する。
例えば、`メモリの使用量`、`スナップショットの保存頻度`、`クライアントの最大接続数`などが調整可能

#### データセットのサイズとメモリ

インメモリデータベースであるため、データセットが物理メモリに収まるように注意する。データセットが大きすぎる場合は、データを分割するなどの対策が必要

#### マルチスレッドの有効化

`Redis 6` 以降では、`マルチスレッド機能`が利用可能。マルチスレッドを有効にすることで、Redis のパフォーマンスを向上させることができる。

### データの圧縮とシリアライゼーションの最適化

#### データ圧縮の有効化

Redis では、データの圧縮を有効にすることでメモリ使用量を削減できる。`redis.conf`ファイルで`zstd`などの圧縮アルゴリズムを有効にすることができる。

#### シリアライゼーションの最適化

Redis はデータを`バイナリ形式`で格納するが、データのシリアライゼーション方法によってパフォーマンスが影響を受けることがあります。適切なシリアライゼーションフォーマットを選択し、パフォーマンスを最適化する。

### データの永続化とバックアップの方法

#### RDB（Redis Database）バックアップ

RDB ファイル形式を使用してデータを永続化できる。`SAVE`コマンドまたは`BGSAVE`コマンドを使用して手動でバックアップを作成することができる。
また、save ディレクティブを使用して自動バックアップのスケジュールを設定することもできる。

#### AOF（Append-Only File）ログ

AOF ログを使用して操作ログを永続化することもできる。AOF ログは Redis の操作履歴を追記する形式で保存され、サーバー再起動時にデータを復元することができる。

## Redis の高度な機能と応用

### パイプライニングとトランザクション

#### パイプライニング

複数のコマンドをまとめて送信し、一括で実行することでネットワークのオーバーヘッドを減らすことができる

```sh
$ redis-cli
> MULTI
> INCR counter
> INCR counter
> EXEC
```

#### トランザクション

複数のコマンドを一連の処理としてまとめて実行し、アトミック性を保証することができる

```sh
$ redis-cli
> MULTI
> SET key1 value1
> SET key2 value2
> EXEC
```

### [Pub/Sub 機能](https://redis.io/docs/latest/develop/interact/pubsub/)

#### Publish と Subscribe の設定

publisher がメッセージを送信し、subscriber がそのメッセージを受け取ることができる

```sh
$ redis-cli
> SUBSCRIBE channel1
```

#### メッセージの publish

PUBLISH コマンドを使用して channel1 チャンネルにメッセージを送信する例

```sh
$ redis-cli
> PUBLISH channel1 "Hello, Redis Pub/Sub!"
```

### Lua スクリプティングと Redis の統合

Lua スクリプティング言語をサポートしており、複数のコマンドを 1 つのスクリプト内で実行することができる
以下の例では、`EVAL`コマンドを使用して`Luaスクリプト`を実行している。スクリプト内で GET コマンドを使用して key1 の値を取得している

```sh
$ redis-cli
> EVAL "return redis.call('GET', KEYS[1])" 1 key1
```

## Redis とキャッシュの利用

### キャッシュとしての Redis の利点と活用例

#### 高速なアクセス

インメモリデータベースであり、高速なデータアクセスを提供する。これにより、リクエストの処理時間を短縮し、パフォーマンスの向上が期待できる

#### データの一時保存

Key/Value の形式でデータを保存するため、一時的なデータの保存に適している。例えば、計算結果や API のレスポンスなどをキャッシュすることで、再計算や再取得のコストを削減できる

### Redis のキャッシュ設計とベストプラクティス

#### キャッシュの有効期限の設定

キャッシュの有効期限を設定することができる。`EXPIRE`コマンドを使用してキーの有効期限を設定することで、自動的にキャッシュが無効化されるようにすることができる。
以下の例では、key1 というキーに value1 という値を設定し、有効期限を 60 秒に設定

```sh
$ redis-cli
> SET key1 value1
> EXPIRE key1 60
```

#### キャッシュの自動更新

GET コマンドなどを使用してキャッシュの値を取得する際に、キャッシュが存在しない場合にバックエンドデータソースからデータを取得し、キャッシュに保存することができる

#### キャッシュの自動削除

メモリを制限するために設定した最大メモリ容量に達した場合、キャッシュを自動的に削除する仕組みがある。この機能を使用することで、メモリ使用量を管理し、過剰なメモリ使用を防ぐことができる

## セキュリティ

### 機能

#### 認証 (Authentication)

Redis にはパスワード認証を設定することができる。これにより、外部からのアクセスを制限し、不正なアクセスからデータを保護することができる

#### アクセス制御 (Access Control)

`Redis 6`以降では、`Role-Based Access Control (RBAC) 機能`が導入されており、ユーザーごとにアクセス権限を制御することができる。ユーザーごとに異なる操作権限を設定することで、データの安全性を向上させることができる。

#### 暗号化 (Encryption)

デフォルトではネットワーク上でデータを暗号化しない。データのセキュリティを確保するためには、`Redisの通信を暗号化するためのTLS/SSL証明書を使用する`必要がある。

### セキュリティ設定方法

#### 認証の設定

設定ファイル (redis.conf) を編集し、`requirepass` ディレクティブを使用してパスワードを設定する。

```conf
# redis.conf

# 認証パスワードの設定
requirepass mypassword
```

#### アクセス制御の設定

設定ファイル (redis.conf) を編集し、`user` ディレクティブを使用してユーザーとロールを設定する。それぞれのユーザーに対して必要な権限を割り当てる。

```conf
# redis.conf

# ユーザーとロールの設定
user alice on nopass ~* +@all -@dangerouscommands
user bob on pass123 ~* +@readonly
```

#### 暗号化の設定

通信を暗号化するには、TLS/SSL 証明書を作成し、Redis サーバーの設定ファイル (redis.conf) を編集する。

- [Redis: TLS](https://redis.io/docs/latest/operate/oss_and_stack/management/security/encryption/)

## References

- [Docs](https://redis.io/docs/latest/)
- [Redis security](https://redis.io/docs/latest/operate/oss_and_stack/management/security/)
- [Redis まとめ](https://engineer.toggle.co.jp/chapter-1-toggle-holdings-engineer-101/ji-chu-yan-xiu/redis)