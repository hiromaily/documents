# DOM (Document Object Model)

DOM (Document Object Model) はツリー構造または階層構造と呼ばれるデータ構造を使って HTML または XML ドキュメントを表現する。
DOM ツリーという階層構造を用いることで、プログラムから HTML や XML 文書を効率的に操作・検索・管理することが可能になる。

## ツリー構造の詳細

### 1. ノード (Node)

- **ノード**: DOM の基本単位。各要素や属性、テキストはノードとして表現される。
- **種類**: 主に以下の種類がある。
  - **要素ノード (Element Node)**: HTML のタグを表すノード。
  - **テキストノード (Text Node)**: 要素内のテキストを表すノード。
  - **属性ノード (Attribute Node)**: 要素の属性を表すノード。ただし、属性ノードは要素ノードの一部として取り扱われる。
  - **コメントノード (Comment Node)**: HTML コメントを表すノード。

### 2. 親子関係

- **親ノード (Parent Node)**: その下に他のノードが位置するノード。
- **子ノード (Child Node)**: 他のノードに属するノード。
- **兄弟ノード (Sibling Node)**: 同じ親ノードを共有するノード。

## DOM ツリーの例

以下に簡単な HTML 文書を例にして、DOM ツリーの構造を説明する。

```html
<!DOCTYPE html>
<html>
  <head>
    <title>My Title</title>
  </head>
  <body>
    <h1>Header</h1>
    <p>Paragraph</p>
  </body>
</html>
```

この HTML ドキュメントに対する DOM ツリーは次のような階層構造になる：

```txt
#document
 ├── <!DOCTYPE html>
 ├── html
      ├── head
      │    └── title
      │         └── "My Title"
      └── body
           ├── h1
           │    └── "Header"
           └── p
                └── "Paragraph"
```

## 各ノードの役割

1. **#document**
   - DOM のルートノード。すべての他のノードはこのノード下に位置する。
2. **<!DOCTYPE html>**
   - ドキュメント型宣言。DOM ツリーには含まれますが、通常操作されることは少ない。
3. **html**
   - `<html>`要素を表すノード。親ノードは`#document`。
4. **head**
   - `<head>`要素を表すノード。親ノードは`html`。
5. **title**
   - `<title>`要素を表すノード。親ノードは`head`。
6. **"My Title"**
   - `title`要素のテキストノード。親ノードは`title`。
7. **body**
   - `<body>`要素を表すノード。親ノードは`html`。
8. **h1**
   - `<h1>`要素を表すノード。親ノードは`body`。
9. **"Header"**
   - `h1`要素のテキストノード。親ノードは`h1`。
10. **p**
    - `<p>`要素を表すノード。親ノードは`body`。
11. **"Paragraph"**
    - `p`要素のテキストノード。親ノードは`p`。

## 実際の操作

JavaScript を使って DOM 構造を操作することが多い。例えば、以下のように DOM ツリーをナビゲートして操作することができる。

```javascript
// ドキュメントのルートhtmlノードにアクセス
let htmlElement = document.documentElement;

// body要素にアクセス
let bodyElement = document.body;

// p要素を探してテキストを変更
let pElement = bodyElement.querySelector("p");
pElement.textContent = "New Paragraph Text";
```

これらの操作により、ブラウザ内でのドキュメントの表示がリアルタイムで更新される。
