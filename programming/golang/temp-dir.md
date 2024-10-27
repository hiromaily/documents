# Goによる一時ファイルの作成 Temp Directory

## [os.CreateTemp](https://pkg.go.dev/os#CreateTemp)

一時ファイルを作成する。

第1引数に "" を指定することで、OS デフォルトのtmpディレクトリにファイルを作成する。
第2引数に指定するのはファイル名ではなく`接頭辞`であり、`接頭辞`から始まり、残りの部分は並列呼び出しされても常に 異なる名前になるよう自動的に決定される。


```go
package main

import (
  "log"
  "os"
)

func main() {
  f, err := os.CreateTemp("", "example")
  if err != nil {
    log.Fatal(err)
  }
  defer os.Remove(f.Name()) // clean up

  if _, err := f.Write([]byte("content")); err != nil {
    log.Fatal(err)
  }
  if err := f.Close(); err != nil {
    log.Fatal(err)
  }
}
```

## [os.MkdirTemp](https://pkg.go.dev/os#MkdirTemp)

`os.MkdirTemp` の引数は `CreateTemp` と同じだが、 ファイルを開く代わりにディレクトリの 名前 を返す。

```go
package main

import (
  "log"
  "os"
  "path/filepath"
)

func main() {
  dir, err := os.MkdirTemp("", "example")
  if err != nil {
    log.Fatal(err)
  }
  defer os.RemoveAll(dir) // clean up

  file := filepath.Join(dir, "tmpfile")
  if err := os.WriteFile(file, []byte("content"), 0666); err != nil {
    log.Fatal(err)
  }
}
```
