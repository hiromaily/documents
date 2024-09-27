# build タグ

ビルドタグ（build tags）は、Go 言語のソースコードを条件付きでビルドするための仕組みであり、これを使うことで、特定のプラットフォーム、バージョン、設定に対して異なるコードをビルドできる

## コード上のビルドタグの意味

1. **ビルドタグの記述方法**:
   ビルドタグは、Go ファイルの冒頭にコメントとして記述される。例えば、以下のようにすると、特定のタグが指定されたときだけそのファイルがビルドに含まれる。

   ```go
   // +build mytag

   package main

   import "fmt"

   func main() {
       fmt.Println("This code is built with 'mytag' build tag")
   }
   ```

2. **複数のタグ条件**:
   複数のタグ条件を指定する場合は論理演算子を用います。

   - **AND 条件**:

     ```go
     // +build linux amd64
     ```

     上記の例は、`Linux` かつ `amd64` アーキテクチャの場合にそのファイルがビルドされることを意味する

   - **OR 条件**:

     ```go
     // +build darwin !cgo
     ```

     これは、MacOS（darwin）か、cgo が無効化されている場合にビルドされる

## ビルドの際の指定方法

コマンドラインで`go build`を実行する際に、特定のタグを指定してビルドすることができる。例えば、`mytag`ビルドタグを使ってビルドする場合は次のようにする。

```sh
go build -tags mytag
```

## 実例

### `integration`タグがあるtestのみを実行する

1. **テストファイルにビルドタグを追加**

   `integration_test.go`という名前でテストファイルを作成し、`integration`ビルドタグを追加

   ```go
   // +build integration

   package main

   import (
       "testing"
   )

   func TestIntegrationExample(t *testing.T) {
       // ここにインテグレーションテストのコードを書く
       t.Log("Running integration test")
   }
   ```

2. **ビルドタグを指定してテストを実行**

   上記のステップで用意したテストファイルを対象に、`integration`タグを指定してテストを実行する。これで、`integration`ビルドタグがついているテストだけが実行される。

   ```sh
   go test -tags=integration
   ```

### 異なるオペレーティングシステムに対して異なる実装を提供したい場合

以下のようにすることで、ビルドする環境に応じて適切なファイルが選択される

- `main_linux.go`:

   ```go
   // +build linux

   package main

   func platformSpecificFunction() {
     fmt.Println("This is Linux specific")
   }
   ```

- `main_windows.go`:

   ```go
   // +build windows

   package main

   func platformSpecificFunction() {
     fmt.Println("This is Windows specific")
   }
   ```

## 組み込みタグ*

Go にはいくつかの組み込みタグも存在します。例えば`linux`, `windows`, `darwin`（MacOS 用）などの OS タグや、`386`, `amd64`などのアーキテクチャタグがあります。これらを利用することで、特定の OS やアーキテクチャに対するビルドを制御できます。
