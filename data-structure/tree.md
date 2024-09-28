# 木構造

[ReadLater]

木構造は多くのアルゴリズムで基本的な役割を果たし、データの効率的な管理と操作を可能にする。適切な木構造を選択することで、特定の問題の解決が効率化される。
木構造は、階層的なデータ構造で、多くの異なる種類が存在する。以下に木構造の基本的な概念と主要な種類について。

## 基本的な概念

1. **ノード (Node)**:
   - 各ノードはデータを持ち、子ノードへの参照を持つ。

2. **ルート (Root)**:
   - 木の最上部に位置するノード。
   - ルートが木全体の入り口となる。

3. **エッジ (Edge)**:
   - ノード間の接続。
   - 一つのノードから他のノードへのリンク。

4. **葉 (Leaf)**:
   - 子ノードを持たないノード。
   - 木の末端に配置される。

5. **内部ノード (Internal Node)**:
   - 少なくとも一つの子ノードを持つノード。

6. **高さ (Height)**:
   - ルートから最大の葉までのパスの長さ。

7. **深さ (Depth)**:
   - そのノードがルートからどれだけ離れているかを示す。

## 主要な種類の木構造

1. **二分木 (Binary Tree)**:
   - 各ノードが最大で二つの子ノードを持つ。
   - 様々な種類の操作やアルゴリズムで利用される。

2. **二分探索木 (Binary Search Tree, BST)**:
   - 各ノードが最大二つの子ノードを持つ二分木。
   - 左子ノードの値が親ノードの値より小さく、右子ノードの値が親ノードの値より大きい。

3. **平衡二分探索木 (Balanced Binary Search Tree)**:
   - 自己平衡性を維持する二分探索木。
   - AVL木、赤黒木などがある。
   - 高さがO(log n)であり、挿入、削除、探索が効率的に行える。

4. **完全二分木 (Complete Binary Tree)**:
   - 全てのレベルが完全に埋まっているか、最後のレベルだけが左から詰めて埋まっている。

5. **完全二分木 (Full Binary Tree)**:
   - 各ノードが零個または二つの子ノードを持つ二分木。

6. **完全木 (Perfect Binary Tree)**:
   - すべての内部ノードが二つの子ノードを持ち、すべての葉が同じ深さまたは高さにある。

7. **B木 (B-Tree)**:
   - データベースやファイルシステムに頻繁に使用される木構造。
   - ノードが複数の子を持つことができる。
   - 高さが低く、ハードディスクに対するアクセス効率を高める。

8. **トライ (Trie)**:
   - 文字列や接頭辞の効率的な管理に使われる。
   - ノードがアルファベットや文字列の部分を持つ。

## 木構造の操作

- **挿入 (Insertion)**:
  - 新しいノードを適切な位置に追加する。
  
- **削除 (Deletion)**:
  - 特定のノードを木から削除し、木の構造を再構築する。
  
- **探索 (Search)**:
  - 特定の値を持つノードを探し出す。

- **巡回 (Traversal)**:
  - 木全体を訪問する方法。
  - 前序 (Preorder), 中序 (Inorder), 後序 (Postorder), 幅優先 (Breadth-First) の巡回方法がある。

## 木構造に適した具体例

- カテゴリ階層構造
- ナビゲーションメニュー

## JSONによる木構造の表現

JSON（JavaScript Object Notation）は、データ構造を階層的に表現できるため、木構造を表現するのに適している。以下に、二分木を例にしてどのようにJSONで木構造を表現できるかを示す。

### 例: 二分探索木 (Binary Search Tree)

二分木の簡単な例。以下の木をJSONで表現する：

```txt
    10
   /  \
  5   15
 / \    \
2   7   20
```

```json
{
  "value": 10,
  "left": {
    "value": 5,
    "left": {
      "value": 2,
      "left": null,
      "right": null
    },
    "right": {
      "value": 7,
      "left": null,
      "right": null
    }
  },
  "right": {
    "value": 15,
    "left": null,
    "right": {
      "value": 20,
      "left": null,
      "right": null
    }
  }
}
```

この例では、各ノードは `value`（ノードの値）、 `left`（左の子ノード）、および `right`（右の子ノード）という3つのフィールドを持つJSONオブジェクトで表現されている。葉ノードには `left` と `right` フィールドが `null` に設定されている。

### 一般的な木構造のJSON表現

より一般的な木構造（例えば、ノードが複数の子ノードを持つ場合）では、以下のように表現できる。例えば、各ノードが複数の子を持つ汎用的な木を次のように表現できる：

```txt
          "root"
         /   |   \
      "c1"  "c2" "c3"
       |       /    \
     "c1.1" "c2.1" "c3.1"

```

```json
{
  "value": "root",
  "children": [
    {
      "value": "c1",
      "children": [
        {
          "value": "c1.1",
          "children": []
        }
      ]
    },
    {
      "value": "c2",
      "children": [
        {
          "value": "c2.1",
          "children": []
        }
      ]
    },
    {
      "value": "c3",
      "children": [
        {
          "value": "c3.1",
          "children": []
        }
      ]
    }
  ]
}
```

この例では、各ノードは `value` と `children`（子ノードのリスト）を持つJSONオブジェクトで表現されている。葉ノードは空の `children` リストを持つ。

### JSONの利点

1. **簡潔で読みやすい**: JSONは人間に読みやすく、書きやすいフォーマットである。
2. **言語独立**: JSONは多くのプログラミング言語でサポートされており、データ交換のフォーマットとして広く使われている。
3. **階層構造の表現**: JSONはネストされたオブジェクトやリストをサポートするので、木構造を直感的に表現できる。

JSONを使って木構造を表現することで、データの視覚化、保存、および転送が容易になる。

## Goによる木構造データのParser

Go言語でJSON形式の木構造データをパースするサンプルプログラムを以下に示す。今回は、最初の例で示した二分探索木（BST）のJSON表現をパースするプログラムを作成する。

### 前提となるJSONデータ

まず、以下のJSONデータをパースする。

```json
{
  "value": 10,
  "left": {
    "value": 5,
    "left": {
      "value": 2,
      "left": null,
      "right": null
    },
    "right": {
      "value": 7,
      "left": null,
      "right": null
    }
  },
  "right": {
    "value": 15,
    "left": null,
    "right": {
      "value": 20,
      "left": null,
      "right": null
    }
  }
}
```

### Goのコード

```go
package main

import (
  "encoding/json"
  "fmt"
)

// ノードを表す構造体
type TreeNode struct {
  Value int       `json:"value"`
  Left  *TreeNode `json:"left"`
  Right *TreeNode `json:"right"`
}

func main() {
  // JSONデータ
  data := `{
    "value": 10,
    "left": {
      "value": 5,
      "left": {
        "value": 2,
        "left": null,
        "right": null
      },
      "right": {
        "value": 7,
        "left": null,
        "right": null
      }
    },
    "right": {
      "value": 15,
      "left": null,
      "right": {
        "value": 20,
        "left": null,
        "right": null
      }
    }
  }`

  // ルートノードを格納する変数を宣言
  var root TreeNode

  // JSONのパース
  if err := json.Unmarshal([]byte(data), &root); err != nil {
    fmt.Println("エラー:", err)
    return
  }

  // パースされた木構造を出力
  printTree(&root, 0)
}

// 木構造を再帰的に出力するヘルパー関数
func printTree(node *TreeNode, level int) {
  if node == nil {
    return
  }

  // 現在のレベルに応じたインデントを表示
  fmt.Printf("%s%d\n", getIndent(level), node.Value)

  // 左右の子ノードを再帰的に表示
  printTree(node.Left, level+1)
  printTree(node.Right, level+1)
}

// インデントを生成するヘルパー関数
func getIndent(level int) string {
  indent := ""
  for i := 0; i < level; i++ {
    indent += "  "
  }
  return indent
}
```

### 実行結果

プログラムを実行すると、次のように木構造が標準出力に表示される。

```
10
  5
    2
    7
  15
    20
```

### 解説

1. **構造体の定義**:
   `TreeNode` 構造体を定義し、`Value`, `Left`, `Right` のフィールドがそれぞれの値と子ノードを表す。

2. **JSONデータのパース**:
   `json.Unmarshal` を使って、JSONデータを `TreeNode` 構造体にパースする。

3. **木構造の出力**:
   `printTree` 関数は木の各ノードを再帰的に表示する。この関数はノードが持つ値を表示し、その後左右の子ノードを再帰的に呼び出す。

4. **インデントの生成**:
   ノードのレベルに応じて適切なインデントを生成するヘルパー関数 `getIndent` を使用して、木の階層構造を視覚的に表現する。

このコードは基本的な木構造のパースと表示を行う例であり、特定の用途や複雑なデータ構造を扱う場合にはさらに拡張が可能である。
