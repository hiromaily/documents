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

## References

- [2024: とりあえずで Docker イメージに Alpine Linux を選択するのはやめましょうという話](https://engineering.nifty.co.jp/blog/26586)
- [2021: 軽量Dockerイメージに安易にAlpineを使うのはやめたほうがいいという話](https://blog.inductor.me/entry/alpine-not-recommended)
