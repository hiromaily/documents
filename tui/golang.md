# Go による実装

以下に、`tview`を使って、`git branch`によって表示された branch 一覧から選択したbranchに切り替えるアプリケーション例を示す

```sh
go get github.com/rivo/tview
```

```go
package main

import (
  "log"
  "os/exec"
  "strings"

  "github.com/rivo/tview"
)

// Gitのブランチ一覧を取得する関数
func getGitBranches() ([]string, error) {
  cmd := exec.Command("git", "branch")
  out, err := cmd.CombinedOutput()
  if err != nil {
    return nil, err
  }

  branches := strings.Split(string(out), "\n")
  var cleanBranches []string
  for _, branch := range branches {
    // 「* 」を削除しトリム
    branch = strings.TrimSpace(strings.TrimPrefix(branch, "* "))
    if branch != "" {
      cleanBranches := append(cleanBranches, branch)
    }
  }
  return cleanBranches, nil
}

// Gitのブランチを切り替える関数
func checkoutBranch(branch string) error {
  cmd := exec.Command("git", "checkout", branch)
  cmd.Stdout = nil
  cmd.Stderr = nil
  return cmd.Run()
}

func main() {
  app := tview.NewApplication()

  // ブランチの取得
  branches, err := getGitBranches()
  if err != nil {
    log.Fatalf("Error getting git branches: %v\n", err)
  }

  // リストビューの作成
  list := tview.NewList()
  for _, branch := range branches {
    branch := branch
    list.AddItem(branch, "", 0, func() {
      if err := checkoutBranch(branch); err != nil {
        log.Printf("Error checking out branch %s: %v\n", branch, err)
      } else {
        log.Printf("Successfully checked out branch %s\n", branch)
      }
    })
  }

  // アプリケーションの設定と起動
  if err := app.SetRoot(list, true).Run(); err != nil {
    log.Fatalf("Error running application: %v\n", err)
  }
}
```

## コードの説明

1. **`getGitBranches`関数**:

   - `git branch` コマンドを実行して、ブランチの一覧を取得する。
   - 出力結果を改行ごとに分割し、各ブランチ名をクリーニング。

2. **`checkoutBranch`関数**:

   - 指定されたブランチへ`git checkout`コマンドで切り替える。

3. **メイン関数**:
   - アプリケーションの初期化。
   - ブランチの一覧を取得し、各ブランチを`tview.List`に追加。
   - 各ブランチをリストに追加する際に、選択された場合のアクション (`checkoutBranch`関数) を定義。
   - `tview.Application` のルートにリストビューを設定して実行。

このコードを実行すると、ターミナル上に Git ブランチの一覧が表示され、矢印キーで選択し、Enter キーで選択したブランチに切り替えすることができる。
