# Golang Tools

## Linter

### [golangci-lint](https://github.com/golangci/golangci-lint)

Goのlinterだが、標準機能だけで完結できるようになったら嬉しい

```sh
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.60.3
```

```sh
golangci-lint run

golangci-lint run --fix
```

### [govulncheck](https://pkg.go.dev/golang.org/x/vuln/cmd/govulncheck)

Goの脆弱性チェックができる。`golangci-lint`には含まれていない。[Add "govulncheck" to golangci-lint](https://github.com/golangci/golangci-lint/issues/4623)

```sh
go install golang.org/x/vuln/cmd/govulncheck@latest
```

```sh
govulncheck ./...
```

### [staticcheck](https://staticcheck.dev/)

- WIP: `golangci-lint`との比較

```sh
go install honnef.co/go/tools/cmd/staticcheck@latest
```

### [mvdan/sh](https://github.com/mvdan/sh)

shellのためのlinter/formatter

```sh
go install mvdan.cc/sh/v3/cmd/gosh@latest
go install mvdan.cc/sh/v3/cmd/shfmt@latest
```

### [golines](https://github.com/segmentio/golines)

1行に含む文字数を指定し、それを超える場合はformatするためのツール

```sh
golines -m 100 -w ./
```

```sh
usage: golines [<flags>] [<paths>...]

Flags:
      --help               Show context-sensitive help (also try --help-long and --help-man).
      --base-formatter=""  Base formatter to use
      --chain-split-dots   Split chained methods on the dots as opposed to the arguments
  -d, --debug              Show debug output
      --dot-file=""        Path to dot representation of AST graph
      --dry-run            Show diffs without writing anything
      --ignore-generated   Ignore generated go files
      --ignored-dirs=vendor... ...
                           Directories to ignore
      --keep-annotations   Keep shortening annotations in final output
  -l, --list-files         List files that would be reformatted by this tool
  -m, --max-len=100        Target maximum line length
      --profile=""         Path to profile output
      --reformat-tags      Reformat struct tags
      --shorten-comments   Shorten single-line comments
  -t, --tab-len=4          Length of a tab
      --version            Print out version and exit
  -w, --write-output       Write output to source instead of stdout

Args:
  [<paths>]  Paths to format
```

- [have you set a max line length (soft/hard) on your projects (state if commercial or open-source/personal, please) in golang?](https://www.reddit.com/r/golang/comments/18xiobg/have_you_set_a_max_line_length_softhard_on_your/?rdt=42860)

こちらで、紹介されている、[Line length](https://google.github.io/styleguide/go/guide#line-length)はためになる

## versionチェック

### [icholy/gomajor](https://github.com/icholy/gomajor)

major versionがupgrade可能かどうかチェックする

```sh
gomajor list
```

## Taskランナー

### [go-task](https://taskfile.dev/)

Go製のtaskランナー。Makefileのほうが使いにくいが、こちらは別途Installが必要になるのが難点。

```sh
brew install go-task/tap/go-task
```

## Test Utility

- [Docs:mock](./mock.md)

### [cweill/gotests](https://github.com/cweill/gotests)

- テスト関数自動生成ツール
- Star: 4.9k
- 開発が2021年で止まっているのでやめたほうがいいかもしれない

### `go test -coverprofile & go tool cover`

- テストカバレッジの可視化

## go.modによるtool管理方法

[内部Docs](./go-modules.md#go-moduleによるbinary-toolの管理)
