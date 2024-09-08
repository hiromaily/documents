# JSON の特殊な機能

## ネストしたオブジェクトと配列

JSON ではオブジェクトや配列をネストして使うことができる。複雑なデータ構造を表現する際に役立つ。

```json
{
  "menu": {
    "id": "file",
    "value": "File",
    "popup": {
      "menuitem": [
        { "value": "New", "onclick": "CreateNewDoc()" },
        { "value": "Open", "onclick": "OpenDoc()" },
        { "value": "Close", "onclick": "CloseDoc()" }
      ]
    }
  }
}
```

## JSON Schema

JSON Schema `"$schema"` は、JSON データの構造を定義するためのツール。データのバリデーションや自動生成、ドキュメント化に役立つ。例えば、API の入力データが正しいかどうかを JSON Schema で確認できる。

例：

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Person",
  "type": "object",
  "properties": {
    "firstName": {
      "type": "string"
    },
    "lastName": {
      "type": "string"
    },
    "age": {
      "type": "integer",
      "minimum": 0
    }
  },
  "required": ["firstName", "lastName"]
}
```

## JSONP

JSONP（JSON with Padding）は、`クロスドメインリクエストを許可するための古いテクニック`だ。これは主に JavaScript で行われる。データは JSON 形式で返されるが、指定された関数名で囲まれる。

サーバから返されるデータの例：

```js
callbackFunction({
  name: "Alice",
  age: 30,
});
```

クライアントコード：

```html
<script src="http://example.com/getData?callback=callbackFunction"></script>
```

## データのコメント (非標準)

JSON 標準ではコメントがサポートされていない。しかし、一部の開発者は`非標準的な方法`でコメントを挿入することがある。例えば、特別なキー名 `_comment` を使う方法などがある。

例：

```json
{
  "name": "Alice",
  "age": 30,
  "_comment": "ageフィールドはユーザーの年齢を示す"
}
```

## メモリ効率

大規模なデータ交換を行う場合、メモリ効率を考慮する必要がある。`大きなサイズの JSON データはパーシングに時間がかかり、メモリを多く消費する`。そういった場合には、ストリーミング処理や複数回に分けてデータを送受信することを検討する。

## JSON Patch

JSON Patch は、`既存の JSON 文書に対する変更を定義するためのフォーマット`。これを利用すると、部分的な更新を効率的に行える。

パッチ文書（operations）の例：

```json
[
  { "op": "replace", "path": "/name", "value": "Bob" },
  { "op": "add", "path": "/address", "value": { "city": "Wonderland" } }
]
```
