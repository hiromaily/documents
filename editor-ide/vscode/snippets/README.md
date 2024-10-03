# Snippets

[Official Docs](https://code.visualstudio.com/docs/editor/userdefinedsnippets)

- `Built-in snippet` と、`Marketplace から install 可能な snippet` が存在する

## どのようなSnippetsが利用できるのか調べるには？

- パレットから、`Snippet search` を選択すると一覧から検索ができる
- パレットから、`Insert Snippet`を選択。例えば、`go`のファイルを開いているのであれば、`go`で利用可能なsnippetsが表示される

### Build-in Typescript

- `if`: Creates a basic if statement.
- `ife`: Creates an if-else statement.
- `for`: Creates a for loop.
- `forin`: Creates a for-in loop.
- `forof`: Creates a for-of loop.
- `foreach`: Creates a for-each loop.
- `trycatch`: Creates a try-catch block.
- `clg`: console.log()
- `cdb`: console.debug()

## Snippetsの作成

自分で snippet を作成することも可能

`Code > Preferences > Configure User Snippets`

### User Snippets

```sh
cd  ~/Library/Application\ Support/Code/User
mkdir snippets
touch snippets/javascript.json # for javascript
touch snippets/typescript.json # for typescript
```

```json
{
  "console.log": {
    "prefix": ["cl"],
    "body": ["console.log()"],
    "description": "console.log()."
  }
}
```
