# Docker image

`debian-slim`が良さげ

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

- [とりあえずで Docker イメージに Alpine Linux を選択するのはやめましょうという話](https://engineering.nifty.co.jp/blog/26586)
