# Bun

`Node.js`に代わる直接的かつ効率的なランタイムとして開発された。2023 年に安定版がリリースされている。

- [official](https://github.com/oven-sh)
- [github](https://github.com/oven-sh/bun)

## 特徴

- `Zig`プログラミング言語で書かれた JavaScript ランタイム
- Node.js とは異なり、Bun は npm に依存せず、動作に外部依存を必要としない
- JavaScriptCore によって動作し、起動時間とメモリ使用量を劇的に削減する
- 代わりに標準ライブラリが組み込まれており、環境変数、HTTP、WebSocket、ファイルシステムなど、多様なプロトコルやモジュールに対応する機能を揃えている
- TypeScript にもデフォルトで対応
- Bun はすべての JavaScript や TypeScript のソースファイルを内部的にトランスパイルするため、追加の設定やトランスパイルなしに、TypeScript ファイルを直接コンパイルして実行する

## 機能

- `hot reload`機能が標準で備わっており、アプリケーションの状態を保持しながら、コードの変更をその場でリフレッシュできる

  - Node.js では、`nodemon　--watch` が必要だった

- `.envファイル`を自動的に読み込む機能

### Bundler

Bun には、必要最小限の設定で様々なモジュール形式をサポートするバンドラーが組み込まれており、さらに、より高速なバンドルに対応するための最適化されているため、そのパフォーマンスは群を抜いている

```sh
bun bundle ͏<source> --out-dir <directory>
```

### テストランナー

```sh
bun test
```

Bun は独自のテストランナーを統合して、スピードと互換性を重視している。メリットは以下の通り

#### スピード

テストランナーがランタイムに組み込まれているため、外部テストフレームワークを読み込む負荷なしにテストを実行できる。その結果、テストの実行が高速化され、大規模なコードベースや継続的インテグレーション環境では特に有益。

#### 互換性

組み込みのテストランナーは、Bun の他の機能とシームレスに動作する。これにより、高速な起動と効率的なメモリ使用量を活かして、本番環境を模倣した環境でテストを確実に実行できる。

#### シンプルさ

組み込みのテストランナーでは、ランタイムとテストフレームワークの設定や互換性の維持について心配する必要がなく、同じ言語機能と API を使用して、アプリケーションコードと同様にテストを記述できる。

### パッケージマネージャー

npm, yarn, pnpm よりも圧倒的に高速で、さらにディスク使用量を削減し、メモリフットプリントを最小限に抑える

シンボリックリンク（ソフトリンク）を採用することで、各プロジェクトのパッケージを一元化された場所にリンクし、後続のプロジェクトでモジュールを再ダウンロードする必要が無くなる

## Node プロジェクトの実行

- Bun は TypeScript ファイルをトランスパイルするため、追加のパッケージは不要

```sh
bun run index.ts
```

## Frontend での利用

- React や Next.js などの JavaScript フレームワークともシームレスに統合できる

## Bun に対応している Framework

- [ElysiaJS](https://github.com/elysiajs/elysia)
  - TypeScript framework supercharged by Bun with End-to-End Type Safety, unified type system, and outstanding developer experience
  - Star: 9.7k
  - [Official](https://elysiajs.com/)
- [Stric](https://github.com/bunsvr)
  - A Bun-first framework for building high performance web applications and APIs
  - Star はまだ少ない
  - [Official](https://stricjs.netlify.app/)
- [Hono](https://github.com/honojs/hono)
  - small, simple, and ultrafast web framework built on Web Standards. Bun にも対応済。
  - Star: 18.1
  - [Official](https://hono.dev/)

## References

- [Awesome Bun](https://github.com/oven-sh/awesome-bun)
