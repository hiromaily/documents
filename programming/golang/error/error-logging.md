# エラーの logging について

エラーロギングは非常に重要なトピックで、システムのデバッグや問題解決に役立つ。関数が入れ子になって呼ばれる場合、どこでエラーロギングを行うべきかは重要。
ここでは、Go でエラーを正しくロギングするためのいくつかの良いアプローチについて説明する。

## ロギングの戦略

エラーロギングの場所や方法を決定する際には、以下のポイントに注意。

1. **エラーはできるだけ早く検出・報告する** - できるだけ低レベル（エラーが発生した直後）に近い場所でエラーをログに記録すると、問題の原因を特定しやすくなる。
2. **エラーハンドリングは全レイヤーで行うが、ロギングは一箇所にまとめる** - 各レイヤーでエラーハンドリングを行いつつも、エラーのロギングはアプリケーションの上位層で一箇所にまとめるのが良い。
3. **コンテキスト情報を追加** - エラーが発生した際のコンテキスト情報（どの関数で発生したか、パラメータの状況など）をエラーメッセージに追加することで、デバッグが容易になる。

### エラーはできるだけ早く検出・報告するパターン

- 最下層でのエラーロギング: 実際にエラーが発生する場所でログを記録。これにより、エラーの発生地点を正確に把握。
- ハンドラでの概要ロギング: エラーが上位の処理（例えばHTTPハンドラなど）に伝搬して最終的にユーザや外部システムに応答する直前に、再度エラーをログに記録。
- コンテキストの追加: 一番最下層では詳細なエラー、上位で文脈情報を追加し、より完全なエラー情報を提供。

### エラーハンドリングは全レイヤーで行うが、ロギングは一箇所にまとめるパターン

- ロギングポイントの集中: トップレベルでのみエラーロギングを行うことで、ログ出力の集中管理が可能になり、ログが冗長にならないようにする。
- エラーの伝搬: 各関数でエラーを適切にラップして上位に伝搬させることで、エラーのコンテキスト情報を付加しながら伝搬させる。
- エラーハンドリングの簡素化: エラーが発生した時点でその場でラップし、最終的なエラーロギング地点（一箇所）までエラーを回送する。

## 追加すべきコンテキスト情報

1. 関数名やファイル名、行番号：どの関数でエラーが発生したかを明確にする。
2. 入力パラメータの値：関数に渡されたパラメータの値を含めると、エラーのトリガーとなった入力が明確になる。
3. スタックトレース：エラーが発生した呼び出し元の詳細な追跡が可能になる。
4. リソースやコンテキスト情報：ファイル名、リソースID、ユーザーIDなど、エラー発生時の具体的なリソースに関連する情報を含める。

## ロギング実装例

```go
package main

import (
    "context"
    "errors"
    "fmt"
    "os"
    "log/slog"
)

// SetupLogger sets up the slog logger
func SetupLogger() *slog.Logger {
    handler := slog.NewTextHandler(os.Stdout)
    logger := slog.New(handler)
    return logger
}


func main() {
    logger := SetupLogger()

    err := topFunction()
    if err != nil {
        // Topレベルでエラーロギングを行う
        logger.Error("Top level error", slog.String("error", err.Error()))
    }
}

// Top
func topFunction() error {
    err := middleFunction()
    if err != nil {
        // エラーをラップして上位に伝搬
        return errors.Join(errors.New("topFunction encountered an error"), err)
    }
    return nil
}

// Middle
func middleFunction() error {
    err := bottomFunction()
    if err != nil {
        // エラーをラップして上位に伝搬
        return errors.Join(errors.New("middleFunction encountered an error"), err)
    }
    return nil
}

// Bottom
func bottomFunction() error {
    // エラーの発生
    return errors.New("an example error occurred")
}
```
