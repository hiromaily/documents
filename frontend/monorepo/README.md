# Monorepo

ひとつの Git リポジトリで複数の NPM パッケージを扱う形態。シングルレポの開発ツールの統一的管理の良さと、マルチレポの再利用可能なモジュールを切り出してリリースする点の両方を兼ね備える。

## ルートパッケージ(root package)

モノレポにおけるトップレベルの NPM パッケージ。通常は、リポジトリのトップレベル。このパッケージはワークスペースを管理するパッケージ。NPM では配布しない。ルートパッケージには、開発ツールの統一的設定や、CI 設定が置かれ、テストフレームワークなどの開発ツールがインストールされる。

## ワークスペース (workspaces)

モノレポにおける NPM で配布するパッケージ。通常、`/packages` ディレクトリにワークスペースごとのディレクトリを作る。
単に`パッケージ`と言った場合は、ワークスペースを指すことがある。モノレポには複数のワークスペースが存在しうる。

## Monorepo tool

- [Which is Better JavaScript Monorepo Tools?](https://npm-compare.com/@microsoft/rush,lerna,nx,turbo)
- [2022 Monorepo Tools](https://2022.stateofjs.com/en-US/libraries/monorepo-tools/)
- [Super 7 JavaScript Monorepo Tools 2024](https://themeselection.com/javascript-monorepo-tools/)
- [The 3 Best Monorepo Tools for 2023](https://itnext.io/the-3-best-monorepo-tools-for-2023-290bd4be8f0b)

### 比較

### [Turborepo](https://turbo.build/repo)

- キャッシュを利用し、差分がある箇所のみのビルドを行うためビルド時間が高速
- 管理しているパッケージ間の依存関係を考慮した順でビルドが可能
- 複数のタスクを並列で実行することが可能
- 依存関係のグラフを可視化可能

### [WIP: Nx](https://nx.dev/)

### [Lerna](https://lerna.js.org/)

Lerna が down trend なので skip

### [Yarn Workspaces](https://yarnpkg.com/features/workspaces)

Yarn が down trend なので skip

## References

- [npm workspaces とモノレポ探検記](https://zenn.dev/suin/scraps/20896e54419069)
- [Turborepo を使ってモノレポ構成の npm パッケージ を管理する](https://cam-inc.co.jp/p/techblog/728530570199434396)
- [モノレポによるマイクロサービスの開発運用](https://note.com/tinkermodejapan/n/nb14009fe837f)
- [【大きいプロジェクトやモノレポ向き？】pnpm の特徴と npm、yarn との比較](https://www.geeklibrary.jp/counter-attack/pnpm/)
  - [Benchmarks of JavaScript Package Managers](https://pnpm.io/benchmarks)
