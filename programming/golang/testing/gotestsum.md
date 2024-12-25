# gotestsum

go testの結果を見やすく整形するツール

[github: gotestsum](https://github.com/gotestyourself/gotestsum)

## Install

```sh
go install gotest.tools/gotestsum@latest
```

`tools.go`によるInstall

```go
// tools.go
//go:build tools
// +build tools

package tools

import (
    _ "gotest.tools/gotestsum"
)
```

## 実行

```sh
# go test ./... 相当
gotestsum

# 組み合わせ
CGO_ENABLED=0 gotestsum -- -race -v ./...

CGO_ENABLED=0 dotenvx run -f .env.test -- gotestsum -- -race -v ./...
```

## gotestsumコマンド

```sh
go gotestsum --help
Usage:
    gotestsum [flags] [--] [go test flags]
    gotestsum [command]

See https://pkg.go.dev/gotest.tools/gotestsum#section-readme for detailed documentation.

Flags:
      --debug                                       enabled debug logging
  -f, --format string                               print format of test input (default "pkgname")
      --format-hide-empty-pkg                       do not print empty packages in compact formats
      --format-icons string                         use different icons, see help for options
      --hide-summary summary                        hide sections of the summary: skipped,failed,errors,output (default none)
      --jsonfile string                             write all TestEvents to file
      --jsonfile-timing-events string               write only the pass, skip, and fail TestEvents to the file
      --junitfile string                            write a JUnit XML file
      --junitfile-hide-empty-pkg                    omit packages with no tests from the junit.xml file
      --junitfile-project-name string               name of the project used in the junit.xml file
      --junitfile-testcase-classname field-format   format the testcase classname field as: full, relative, short (default full)
      --junitfile-testsuite-name field-format       format the testsuite name field as: full, relative, short (default full)
      --max-fails int                               end the test run after this number of failures
      --no-color                                    disable color output
      --packages list                               space separated list of package to test
      --post-run-command command                    command to run after the tests have completed
      --raw-command                                 don't prepend 'go test -json' to the 'go test' command
      --rerun-fails int[=2]                         rerun failed tests until they all pass, or attempts exceeds maximum. Defaults to max 2 reruns when enabled
      --rerun-fails-max-failures int                do not rerun any tests if the initial run has more than this number of failures (default 10)
      --rerun-fails-report string                   write a report to the file, of the tests that were rerun
      --rerun-fails-run-root-test                   rerun the entire root testcase when any of its subtests fail, instead of only the failed subtest
      --version                                     show version and exit
      --watch                                       watch go files, and run tests when a file is modified
      --watch-chdir                                 in watch mode change the working directory to the directory with the modified file before running tests

Formats:
    dots                     print a character for each test
    dots-v2                  experimental dots format, one package per line
    pkgname                  print a line for each package
    pkgname-and-test-fails   print a line for each package and failed test output
    testname                 print a line for each test and package
    testdox                  print a sentence for each test using gotestdox
    github-actions           testname format with github actions log grouping
    standard-quiet           standard go test format
    standard-verbose         standard go test -v format

Format icons:
    default                  the original unicode (✓, ∅, ✖)
    hivis                    higher visibility unicode (✅, ➖, ❌)
    text                     simple text characters (PASS, SKIP, FAIL)
    codicons                 requires a font from https://www.nerdfonts.com/ (  )
    octicons                 requires a font from https://www.nerdfonts.com/ (  )
    emoticons                requires a font from https://www.nerdfonts.com/ (󰇵 󰇶 󰇸)

Commands:
    gotestsum tool slowest   find or skip the slowest tests
    gotestsum help           print this help next
```

## gotestsumの実行結果のレポート

Github Actionsで実行するためには、[dorny/test-reporter](https://github.com/dorny/test-reporter)を利用する。

```yml
permissions:
  pull-requests: write
  contents: write
  statuses: write
  checks: write
  actions: write

jobs:
  test:
    runs-on: ubuntu-latest
    env:
      DOTENV_PRIVATE_KEY_TEST: ${{ secrets.DOTENV_PRIVATE_KEY_TEST }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Install dependencies
        run: |
          curl -fsS https://dotenvx.sh/install.sh | sh

      - name: Setup Go
        uses: actions/setup-go@v5
        with:
          go-version-file: './batch/go.mod'
          cache: false

      - name: Install gotestsum
        run: |
          go install gotest.tools/gotestsum@latest

      - name: Run Unit Tests and generate JUnit report, test coverage
        run: |
          echo "ユニットテストの実行"
          cd batch
          dotenvx run -f .env.test -- gotestsum --junitfile unit-tests.xml -- -race -short -v ./...

      - name: Test Report Summary
        if: success() || failure()
        uses: dorny/test-reporter@v1
        with:
          name: Go Unit Tests
          path: "batch/*.xml"
          reporter: java-junit
          fail-on-error: 'true'
```

`Test Report Summary`セクションの実行結果例

```txt
Creating test report Go Unit Tests
  Processing test results for check run Go Unit Tests
  Creating check run Go Unit Tests
  Creating report summary
  Generating check run summary
  Creating annotations
  Updating check run conclusion (success) and output
  Check run create response: 200
  Check run URL: https://api.github.com/repos/org/project/check-runs/348496874xx
  Check run HTML: https://github.com/org/project/runs/348496874xx
```

## References

- [gotestsumを使いこなしてGoのテスト体験を向上したい](https://zenn.dev/jy8752/articles/40a3190da46fc7)
