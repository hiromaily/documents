# Golang Tools

## Linter

### [golangci-lint](https://github.com/golangci/golangci-lint)

Goのlinterだが、標準機能だけで完結できるようになったら嬉しい

```sh
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.60.3
```

### [govulncheck](https://pkg.go.dev/golang.org/x/vuln/cmd/govulncheck)

Goの脆弱性チェックができる。`golangci-lint`には含まれていない。[Add "govulncheck" to golangci-lint](https://github.com/golangci/golangci-lint/issues/4623)

```sh
go install golang.org/x/vuln/cmd/govulncheck@latest
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

## versionチェック

### [icholy/gomajor](https://github.com/icholy/gomajor)

major versionがupgrade可能かどうかチェックする

## Taskランナー

### [go-task](https://taskfile.dev/)

Go製のtaskランナー。Makefileのほうが使いにくいが、こちらは別途Installが必要になるのが難点。

```sh
brew install go-task/tap/go-task
```

