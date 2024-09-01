# Biome

Rust 製の高速な format, lint ツール

- [Official](https://biomejs.dev/ja/)
- [github](https://github.com/biomejs/biome)
  - Star: 13.8k
- [Formatter: Prettier との違い](https://biomejs.dev/ja/formatter/differences-with-prettier/)
- [Linter](https://biomejs.dev/ja/linter/)

2024/9 現在、`v1.8.3`

## コマンド

- ファイルやディレクトリを format
  - `bunx biome format --write <files>`
- ファイルやディレクトリに対して Lint を実行
  - `bunx biome lint --write <files>`
- 両方のコマンドを実行
  - `bunx biome check --write <files>`

また、[import 文のソート](https://biomejs.dev/ja/analyzer/import-sorting/)もデフォルトで有効

## `scripts`への追加

```json
"scripts": {
  "lint": "bunx @biomejs/biome lint --write ./src",
  "format": "bunx @biomejs/biome format --write ./src",
  "check": "bunx @biomejs/biome check --write ./src"
}
```

## References

- [TypeScript の実行環境を Bun と Biome に移行してみた](https://zenn.dev/pe_be_o/articles/maeta-187-articles_c7602bb31f03d7)
