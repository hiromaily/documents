# Useful functionalities

## WIP: Go 1.23

[Go 1.23 Release Notes](https://tip.golang.org/doc/go1.23), [Blog: Go 1.23 is released!](https://go.dev/blog/go1.23)

## Go 1.22

[Go 1.22 Release Notes](https://tip.golang.org/doc/go1.22), [Blog: Go 1.22 is released!](https://go.dev/blog/go1.22)

- ループの処理の変化
  - [参考](https://future-architect.github.io/articles/20240129a/)
- Slice に Concat() API の追加

## Go 1.21

[Go 1.21 Release Notes](https://tip.golang.org/doc/go1.21), [Blog: Go 1.21 is released!](https://go.dev/blog/go1.21)

- ジェネリクスのためのパッケージ `slices`,`maps`の追加
- 組み込み関数 `min`, `max`, `clear` の追加
- コアライブラリの追加
  - `slog`パッケージ
  - `slices`, `maps`, `cmp` パッケージ

### [slog](https://pkg.go.dev/log/slog@master)

- インタフェースではなく実装
- structured + leveled logging 可能
- ネストした structure も可能
- slog.SetDefault を呼ぶと標準の log パッケージの出力も slog になる
- テキスト形式のほか、JSON 形式の出力も手軽にできる
- API トークンなどをログに出さないよう型ベースで設定できる

## Go 1.20

[Go 1.20 Release Notes](https://tip.golang.org/doc/go1.20)

- [PGO: Profile-guided optimization](https://go.dev/doc/pgo)
  - まだ preview 段階
  - ビルド時にプロファイルを提供することにより、コンパイラは一般的なアプリケーションを約 3 ～ 4%高速化することができる
- 標準ライブラリの追加
  - [crypto/ecdh](https://pkg.go.dev/crypto/ecdh)パッケージ
  - [errors.Join](https://pkg.go.dev/errors#Join)関数: エラータイプに`Unwrap() []error`メソッドが実装されている場合、再度取得することができるエラーのリストをラップしたエラーを返す
- パフォーマンスの向上

## Go 1.19

[Go 1.19 Release Notes](https://tip.golang.org/doc/go1.19)

- 変更のほとんどは、tool chain, runtime, ライブラリの実装となる
- 目立った修正は見られない

## Go 1.18

[Go 1.18 Release Notes](https://tip.golang.org/doc/go1.18)

- Generics
- Fuzzing tools

### Fuzzing (Since Go1.18)

- [Fuzzing is Beta Ready](https://blog.golang.org/fuzz-beta)
- [Design Draft: First Class Fuzzing](https://go.googlesource.com/proposal/+/master/design/draft-fuzzing.md)
- [Go 言語でファジング](https://deeeet.com/writing/2015/12/21/go-fuzz/)
- [dvyukov/go-fuzz](https://github.com/dvyukov/go-fuzz)

## Go 1.17

[Go 1.17 Release Notes](https://golang.org/doc/go1.17)
目立った修正は見当たらない

## Go 1.16

[Go 1.16 Release Notes](https://golang.org/doc/go1.16)

- Module-aware mode is enabled by default. `GO111MODULE` environment variable now defaults to `on`.
- Build commands like go build and go test no longer modify go.mod and go.sum by default.
- go install now accepts arguments with version suffixes (for example, go install example.com/cmd@v1.0.0). This causes go install to build and install packages in module-aware mode, ignoring the go.mod file in the current directory or any parent directory.

### Embedding Files

- The go command now supports including static files and file trees as part of the final executable, using the new `//go:embed` directive.
- [Package embed](https://golang.org/pkg/embed/)
- [Go 1.16 からリリースされた go:embed とは](https://future-architect.github.io/articles/20210208/)

## deprecated

- The `-i` flag accepted by go build, go install, and go test is now deprecated.
