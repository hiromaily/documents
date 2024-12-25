# Test Coverage

パッケージ~~ファイル~~単位でカバレッジを計測する。`Go 1.22`からテストファイルのないファイルでもカバレッジが表示せれるようになった。

## 統計データの種類

- パッケージ単位のカバレッジ（%）
- 関数ごとのカバレッジ（%）
- 全体のカバレッジ（%）

## go testのcoverageオプション

### `-cover`オプション

```sh
go test -cover ./...

=== RUN   TestFooBar/success
--- PASS: TestFooBar (0.00s)
    --- PASS: TestFooBar/success (0.00s)
PASS
coverage: 75.9% of statements
=== RUN   TestFooBar/success
--- PASS: TestFooBar (0.00s)
    --- PASS: TestFooBar/success (0.00s)
PASS
coverage: 85.3% of statements
```

### `-coverprofile`オプション

coverageレポートを出力する
コンボボックスにファイル名の一覧とカバレッジ計測率が表示される。

```sh
go test -coverprofile=coverage.out ./...

# coverageをHTML形式で出力し、ブラウザで確認
go tool cover -html=coverage.out -o coverage.html

# 関数毎のカバレッジを確認
go tool cover -func=coverage.out
```

## `go tool cover`コマンド

```sh
> go tool cover --help
Usage of 'go tool cover':
Given a coverage profile produced by 'go test':
    go test -coverprofile=c.out

Open a web browser displaying annotated source code:
    go tool cover -html=c.out

Write out an HTML file instead of launching a web browser:
    go tool cover -html=c.out -o coverage.html

Display coverage percentages to stdout for each function:
    go tool cover -func=c.out

Finally, to generate modified source code with coverage annotations
for a package (what go test -cover does):
    go tool cover -mode=set -var=CoverageVariableName \
        -pkgcfg=<config> -outfilelist=<file> file1.go ... fileN.go

where -pkgcfg points to a file containing the package path,
package name, module path, and related info from "go build",
and -outfilelist points to a file containing the filenames
of the instrumented output files (one per input file).
See https://pkg.go.dev/cmd/internal/cov/covcmd#CoverPkgConfig for
more on the package config.

Flags:
  -V    print version and exit
  -func string
        output coverage profile information for each function
  -html string
        generate HTML representation of coverage profile
  -mode string
        coverage mode: set, count, atomic
  -o string
        file for output
  -outfilelist string
        file containing list of output files (one per line) if -pkgcfg is in use
  -pkgcfg string
        enable full-package instrumentation mode using params from specified config file
  -var string
        name of coverage variable to generate (default "GoCover")

  Only one of -html, -func, or -mode may be set.
```

## Tools/Services

- [Codecov](https://about.codecov.io/)
  - [Codecov GitHub Action](https://github.com/codecov/codecov-action)
- [octocov](https://github.com/k1LoW/octocov)

### [octocov](https://github.com/k1LoW/octocov)

```sh
# Install
brew install k1LoW/tap/octocov
# or
go install github.com/k1LoW/octocov@latest
```

## References

- [Goのカバレッジツールを使いこなす](https://gihyo.jp/article/2023/03/tukinami-go-05)
- [2024年版 コードカバレッジ可視化の「ちょうどいい」やり方](https://www.estie.jp/blog/entry/2024/08/09/141550)
