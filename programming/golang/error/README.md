# Go Error

## References

- [Google: General error handling rules](https://developers.google.com/tech-writing/error-messages/error-handling)
  - [Error handling](https://google.github.io/styleguide/go/best-practices#error-handling)

## エラーパッケージ

- [errors](https://pkg.go.dev/errors)
  - 標準ライブラリで、ほぼこれ一択と言える状況
- [github.com/pkg/errors](https://github.com/pkg/errors)
  - 2020年頃まではよく利用されていたが、現在は `public archive`状態
- [golang.org/x/xerrors](https://pkg.go.dev/golang.org/x/xerrors)
  - こちらでの実装のいくつかが、標準パッケージに取り込まれている。現在も継続中。
- [cockroachdb/errors](https://github.com/cockroachdb/errors)
  - かなり高機能で、他のエラーパッケージとの比較表がある
  - `stack trance`機能を使いたい場合、こちらが有効

## エラーの作成方法

```go
import (
    "errors"
    "fmt"
)

// errorsパッケージによるエラー
var ErrNegativeNumber = errors.New("negative number is not allowed")

// fmt.Errorfによるエラー
err := fmt.Errorf("user %s not found", name)
```

## TODO: エラーの構造化について

- HTTP のようにコードとメッセージを管理するパターン

## 2020: [Why Go's Error Handling is Awesome](https://rauljordan.com/why-go-error-handling-is-awesome/)

Goのエラーハンドリングは、開発者に対してエラーを無視できないようにし、エラー処理をプログラムの重要な部分として位置づけている。これにより、より堅牢で理解しやすいコードを書くことが可能になる。

### Goのエラーハンドリングの特徴

- **エラーを第一級の市民として扱う**: Goでは、エラーは関数の戻り値として扱われ、開発者はエラーを無視することが難しくなっている。これにより、エラー処理がプログラムのフローにおいて重要視される。

- **明示的なエラーチェック**: Goの標準的なエラーハンドリングの方法は、`if err != nil`という構文を使用すること。この構文は、エラーが発生した場合に明示的に処理を行うことを促す。

### エラーハンドリングの利点

1. **隠れた制御フローがない**: エラー処理が明示的であるため、プログラムの流れが分かりやすくなる。
2. **予期しない例外のログが発生しない**: Goでは、プログラムがクラッシュしない限り、エラーが無視されることはない。
3. **エラーを値として扱う**: エラーを値として扱うことで、開発者はエラーを返したり、処理したりすることができる。

### 他の言語との比較

- **例外処理**: JavaScriptなどの言語では、例外をスローすることでエラーを処理するが、Goではエラーを明示的にチェックする必要がある。これにより、Goではエラー処理がより透明で、開発者が責任を持ってエラーを扱うことが求められる。

### Goの哲学

- **シンプルさが重要**: Goの哲学には「シンプルさが重要」と「失敗を計画する」という2つの重要な教訓がある。これにより、エラー処理がプログラムの設計において中心的な役割を果たす。

### エラーチェーンの利点

Goでは、エラーをチェーンとして扱うことができ、エラーの発生源を追跡しやすくなる。例えば、エラーがどの関数で発生したのかを明確にすることで、デバッグが容易になる。
