# Docker image

Alpineを使うべきではないという意見及び、`debian-slim`が推奨されるケースが多い。

## 軽量な image

- debian-slim
  - alpine や destroless と比べると若干 image サイズが大きい
- alpine
  - `glibc`がないため、glibc に依存するバイナリは動作しない
  - `glibc`に依存するソースのビルドに失敗する
  - パフォーマンス劣化の可能性
  - apk パッケージを固定できない
  - 互換性・パフォーマンスの担保ができない
- [distroless](https://github.com/GoogleContainerTools/distroless)
  - パッケージマネージャが存在しない
  - シェルがない。これによりコンテナ内へのログインが不可能
  - multi-stage ビルド専用として割り切るなど
- [scratch](https://hub.docker.com/_/scratch/)

## `latest`タグを使うデメリット

2025/3確認: imageを一度ダウンロードすると、更新されない。
例えば、localstackのバージョンは4.2が最新だが、`docker logs localstack | grep -i "LocalStack version"`で確認したら、`3.7`だった。

1. **再現性の欠如**:
   `latest`タグを指定すると、Dockerイメージの内容が変更されるたびに新しいバージョンがダウンロードされる。これにより、同じ`docker-compose`ファイルを使用しても、異なるバージョンのコンテナがデプロイされる可能性があり、開発環境や本番環境に一貫性を持たせることができない。

2. **予期しない変更**:
   `latest`タグは常に最新のイメージを参照するため、新しいバージョンのイメージがリリースされるたびに自動的にそれが使用される。これにより、互換性が破壊される変更やバグの影響を受ける可能性があり、システムが予期しない動作を起こす原因になる。

3. **デバッグの困難さ**:
   特定のイメージバージョンを指定していないと、問題が発生したときにどのバージョンのイメージで発生しているのかを特定するのが難しくなります。これにより、バグの特定と修正が困難になります。

4. **依存関係の管理が難しい**:
   チーム全体で一貫した開発環境を維持することが難しくなります。開発者ごとにローカルで実行されているイメージのバージョンが異なると、同じコードが期待通りに動作しないといった問題が発生します。

これらの理由から、特定のバージョンタグ（例: `localstack/localstack:0.12.11`）を使用することが推奨される。
これにより、環境の再現性が向上し、予期しない問題を回避することができる。

### Latestのバージョンの確認方法

利用しているimageごとに確認方法は異なるが、localstackであれば、logから確認できる

```sh
docker logs localstack | grep -i "LocalStack version"
```

### Latestのバージョンのアップデート方法

```sh
docker pull localstack/localstack:latest
```

## References

- [2024: とりあえずで Docker イメージに Alpine Linux を選択するのはやめましょうという話](https://engineering.nifty.co.jp/blog/26586)
- [2021: 軽量Dockerイメージに安易にAlpineを使うのはやめたほうがいいという話](https://blog.inductor.me/entry/alpine-not-recommended)
