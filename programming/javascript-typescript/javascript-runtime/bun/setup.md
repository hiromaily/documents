# Bun Setup

## Install

```sh
curl -fsSL https://bun.sh/install | bash

# version確認
bun --version
```

2024/9 現在、[volta での bun install は未対応](https://github.com/volta-cli/volta/issues/1465)

## Bun への移行について

Bun の Node.js モジュールに対する堅牢なサポート、グローバル変数の認識、および Node.js モジュール解決アルゴリズムへの準拠によって、Node.js から Bun への移行プロセスが簡素化されている。

環境変数の管理に`dotenv`パッケージを利用している Node.js プロジェクトを抱えている場合、Bun には`.envファイルを自動的に読み込む機能`が組み込まれているため、dotenv パッケージが不要
