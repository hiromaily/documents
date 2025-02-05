# [Function calling](https://platform.openai.com/docs/guides/function-calling)

Function Callingは、ユーザーの入力を分析して、外部の関数を呼び出す必要がある場合、その関数の呼び出しに関する情報を提供する。これにより、AIモデルは外部のシステムやAPIとミスなく接続して、より正確な回答を生成できる。

## どのように機能するか

1. **関数の定義**: 開発者は事前に関数の定義をAPIに指定する。
2. **ユーザーの質問**: ユーザーがプロンプトを入力すると、AIモデルはその質問に応じて、適切な関数を呼び出す必要があるかどうかを判断する。
3. **関数呼び出し**: モデルが関数呼び出しを必要とする場合、関数名と引数を含むJSONオブジェクトを出力する。
4. **関数の実行**: サーバーはこの出力情報を使用して、指定された関数を実行し、その結果を取得する。
5. **回答の生成**: モデルは関数の結果を使用して、最終的な回答を生成する。

## 利用例

最もよく挙げられる例としては、「天気の質問」がある。ユーザーが「東京の天気は？」と問うと、AIモデルは天気情報を取得する関数を呼び出し、その結果を使用して回答を生成する。

## サポートされているモデル

すべてのOpenAIモデルがFunction Callingをサポートするわけではない。

## 並列関数呼び出し

一部のモデルでは並列関数呼び出しがサポートされており、複数の関数呼び出しを一度の出力で行うことができる。各関数の結果は、関数呼び出し要求の`id`と一致する`tool_call_id`を含む会話に新しいメッセージとして含まれる。

## セマンティック カーネル SDK

セマンティック カーネル SDKは、`KernelFunction`デコレーターを使用しているAIに対して関数呼び出しを可能にする。カーネルはデコレーターに基づいて要求の`tools`パラメーターをビルドし、要求された関数呼び出しをコードに調整し、結果をモデルに返す。

## トークン数の考慮

関数の説明は、モデルへの要求のシステムメッセージに含まれるため、トークン制限に対してカウントされ、要求のコストに含まれる。トークン制限を超える場合は、関数の数を減らすか、JSONの関数と引数の説明を短くする。
