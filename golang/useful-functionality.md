# Useful functionalities

## Upcoming functionality

#### Fuzzing

- [Fuzzing is Beta Ready](https://blog.golang.org/fuzz-beta)
- [Design Draft: First Class Fuzzing](https://go.googlesource.com/proposal/+/master/design/draft-fuzzing.md)
- [Go 言語でファジング](https://deeeet.com/writing/2015/12/21/go-fuzz/)
- [dvyukov/go-fuzz](https://github.com/dvyukov/go-fuzz)

## Go 1.20
[Go 1.20 Release Notes](https://tip.golang.org/doc/go1.20)


## Go 1.19

[Go 1.19 Release Notes](https://tip.golang.org/doc/go1.19)
- 変更のほとんどは、tool chain, runtime, ライブラリの実装となる
- 目立った修正は見られない

## Go 1.18

[Go 1.18 Release Notes](https://tip.golang.org/doc/go1.18)

- Generics
- Fuzzing tools

## Go 1.17

[Go 1.17 Release Notes](https://golang.org/doc/go1.17)
目立った修正は見当たらない

## Go 1.16

[Go 1.16 Release Notes](https://golang.org/doc/go1.16)

- Module-aware mode is enabled by default. `GO111MODULE` environment variable now defaults to `on`.
- Build commands like go build and go test no longer modify go.mod and go.sum by default.
- go install now accepts arguments with version suffixes (for example, go install example.com/cmd@v1.0.0). This causes go install to build and install packages in module-aware mode, ignoring the go.mod file in the current directory or any parent directory.

#### deprecated

- The `-i` flag accepted by go build, go install, and go test is now deprecated.

#### Embedding Files

- The go command now supports including static files and file trees as part of the final executable, using the new `//go:embed` directive.
- [Package embed](https://golang.org/pkg/embed/)
- [Go 1.16 からリリースされた go:embed とは](https://future-architect.github.io/articles/20210208/)
