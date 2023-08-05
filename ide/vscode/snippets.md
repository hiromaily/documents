# Snippets
[Official Docs](https://code.visualstudio.com/docs/editor/userdefinedsnippets)

- Built-in snippetと、Marketplaceからinstall可能なsnippetが存在する
- 自分でsnippetを作成することも可能
  - `Code > Preferences > Configure User Snippets`
- パレットから、`Snippet serach`を選択すると一覧から検索ができる

## Build-in Typescript
- `if`: Creates a basic if statement.
- `ife`: Creates an if-else statement.
- `for`: Creates a for loop.
- `forin`: Creates a for-in loop.
- `forof`: Creates a for-of loop.
- `foreach`: Creates a for-each loop.
- `trycatch`: Creates a try-catch block.
- `clg`: console.log()
- `cdb`: console.debug()

## User Snippets
```json
{
  "console.log": {
    "prefix": [
      "cl"
    ],
    "body": [
      "console.log()"
    ],
    "description": "console.log()."
  }
}
```

