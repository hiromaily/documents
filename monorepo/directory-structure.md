# Monorepo構成

`apps`ディレクトリや`packages`ディレクトリは、monorepo構成において非常に一般的な概念で、これにより、異なる種類のコードベース（例えば、ApplicationコードとLibraryコード）を整理・管理しやすくなる。

## 一般的なmonorepoディレクトリ構造の概念

1. **`apps`ディレクトリ**：
   - ここには、実行可能なアプリケーションが格納される。
   - アプリケーションは独自のエントリーポイント（例：Reactアプリケーションの`src/index.js`等）を持ち、独自の依存関係を持つことが一般的。
   - 複数の異なるアプリケーション（例えば、フロントエンドとバックエンド）を別々に管理するために使用される。

2. **`packages`ディレクトリ**：
   - ここには、再利用可能なライブラリやモジュールが格納される。
   - ライブラリやモジュールは、他のアプリケーションや他のパッケージ内で使用されることが多い。
   - よく使われるユーティリティ関数、カスタムフック、設定ファイルなど、共通のコードを管理する。

## なぜこれが一般的なのか？

- **スケーラビリティ**: 大規模なプロジェクトでも整理しやすく、管理がしやすい。
- **再利用性**: 共通のコードやライブラリを一元管理できるため、再利用性が高まる。
- **依存関係管理**: 各ディレクトリごとに依存関係を明確に管理できるため、モジュール間の依存関係が分かりやすくなる。
- **チームコラボレーション**: 複数のチームがそれぞれのアプリケーションやライブラリを別々に開発・デプロイできる。

## 具体的な例

```txt
my-monorepo/
  ├── package.json  # ルートのpackage.json
  ├── packages/
  │   ├── package-a/
  │   │   ├── package.json
  │   │   └── src/
  │   └── package-b/
  │       ├── package.json
  │       └── src/
  └── apps/
      ├── app1/
      │   ├── package.json
      │   └── src/
      └── app2/
          ├── package.json
          └── src/
```

## このやり方を推奨しているパッケージマネージャーやmonorepoツール

- [Turborepo:Structuring a repository](https://turbo.build/repo/docs/crafting-your-repository/structuring-a-repository)
- [Nx: Folder Structure](https://nx.dev/concepts/decisions/folder-structure)
  - `packages`ではなく`libs`を使っている
- [Novu: Monorepo Structure](https://docs.novu.co/community/monorepo-structure)
- [Monorepo With PNPM Workspace](https://anasrar.github.io/blog/monorepo-with-pnpm-workspace/)
  - `apps/*` and `packages/*` is very popular monorepo structure, where `apps/*` is projects directory and `packages/*` is reusable code.
- [monorepo.tools](https://monorepo.tools/)
- [rushstack](https://github.com/microsoft/rushstack)
  - [rush-example](https://github.com/microsoft/rush-example)
