# Markdown

`# 見出し`, `* リスト` など、シンプルな書き方で文書構造を明示でき、装飾されたHTML文書に変換できる軽量マークアップ言語

## Formatter

### Vscode

- [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)

```json
{
  "[markdown]": {
    "editor.wordWrap": "on",
    "files.trimTrailingWhitespace": false,
    "editor.trimAutoWhitespace": false,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
  },
}
```

### CLI

- [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)

```sh
brew install markdownlint-cli2
```

```sh
markdownlint-cli2 --fix "**/*.md"
```

## References

- [Markdown 50のルール](https://qiita.com/antk/items/e11cac45f9da343e7bf0)
