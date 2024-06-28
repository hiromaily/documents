# Docker image

## 軽量な image

- debian-slim
  - alpine や destroless と比べると若干 image サイズが大きい
- alpine
  - `glibc`がないため、glibc に依存するバイナリは動作しない
  - `glibc`に依存するソースのビルドに失敗すうｒ
  - パフォーマンス劣化の可能性
  - apk パッケージを固定できない
- [distroless](https://github.com/GoogleContainerTools/distroless)
  - パッケージマネージャが存在しない
  - シェルがない。これによりコンテナ内へのログインが不可能
  - multi-stage ビルド専用として割り切るなど
- [scratch](https://hub.docker.com/_/scratch/)
