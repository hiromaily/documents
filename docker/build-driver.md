# Docker Build Drivers

[Build drivers](https://docs.docker.com/build/builders/drivers/)

ビルド ドライバーは、BuildKit バックエンドの実行方法と実行場所の構成となる。ドライバー設定はカスタマイズ可能で、ビルダーを細かく制御できる。Buildx は次のドライバーをサポートしている。

- docker: Docker デーモンにバンドルされている BuildKit ライブラリを使用する。
- docker-container: Docker を使用して専用の BuildKit コンテナを作成する。
- kubernetes: Kubernetes クラスターに BuildKit ポッドを作成する。
- remote: 手動で管理される BuildKit デーモンに直接接続する。

`dockerドライバーはすべてのキャッシュ エクスポート オプションをサポートしていない`、戸あるので注意が必要
