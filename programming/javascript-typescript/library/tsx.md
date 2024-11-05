# [tsx](https://github.com/privatenumber/tsx)

tsxは、TypeScript (TS) と拡張された TypeScript (TSX) 両方のファイルを直接実行できるツール。tsxは`esbuild`をバックエンドに利用しており、高速なトランスパイルを実現している。Reactコンポーネントで使うJSXスタイルの構文（.tsxファイル）についてもネイティブに対応している。

Star: 9.6k

## [esbuild-register](https://github.com/egoist/esbuild-register)

Star: 989

## ts-node

ts-nodeによって、JavaScriptにトランスパイルせずに直接TypeScriptコードを実行することができる。とはいえ、内部的にはトランスパイルしてから実行している。

### ts-nodeのデメリット

- ts-nodeでもTypescriptをトランスパイルしないで実行できるが遅い
- nodeのバージョンが20.xになると動かない (2024/10現在)

## Typescript実行ライブラリ：類似パッケージ

- [ts-node](https://github.com/TypeStrong/ts-node)
- [esbuild-register](https://github.com/egoist/esbuild-register)
