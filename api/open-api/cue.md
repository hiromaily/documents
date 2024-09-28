# CUE

CUE（Configuration, Unification, and Extraction）は、コンフィギュレーションを記述するためのDSL（ドメイン特化言語）で、データの定義、テンプレート、検証を統一した形で行うためのツール

## 主な特徴や利点

1. **構造化データの定義**:
    - CUEは構造化データを定義するのに適している。JSONやYAMLのような形式を扱いつつ、さらに型や制約を追加してデータの一貫性を保証する。

2. **型システムとバリデーション**:
    - CUEは強力な型システムを持っており、データの一貫性と正確性をチェックするためのバリデーションルールを簡便に定義できる。

3. **テンプレートのサポート**:
    - 繰り返し使うパターンやテンプレートを定義して再利用しやすく、DRY（Don't Repeat Yourself）原則に従ったデータ記述が可能。

4. **統一された環境**:
    - 設定の記述とそのバリデーションを一貫して行えるので、異なるツールや言語で設定を記述する際の不整合を減らせる。

OpenAPIとCUEを組み合わせることにより、フロントエンドとバックエンドで使用する型定義を一元管理しやすくなる。例えば、CUEスキーマでOpenAPI仕様を定義し、その型定義を利用してTypeScriptやGoなど任意のプログラミング言語に変換することで、コードの一貫性を保ちながら、両者間で共通の型を使用できる。

## 手順

1. **CUEでOpenAPIスキーマを定義**:
    - APIのエンドポイント、リクエスト、レスポンスの型をCUEで記述する。

2. **コード生成ツールを利用**:
    - CUEファイルからTypeScriptやGoのコードを生成するツールを使用し、両者の型定義を一致させる。また、API仕様の変更があった場合もCUEファイルを更新するだけで、再生成することで一貫性を保てる。

3. **バリデーションの一元化**:
    - フロントエンドとバックエンドで同じCUEバリデーションルールを使用することで、一貫したデータ検証を行う。

CUEを使用すると、設定ファイルをより管理しやすく、API定義の一貫性を保ちながらフロントエンドとバックエンドの型定義を共通化でき、開発プロセスの効率化が期待される。

## References

- [Official](https://cuelang.org/)
  - [How CUE works with OpenAPI](https://cuelang.org/docs/concept/how-cue-works-with-openapi/#using-openapi-with-the-go-api)
- [github](https://github.com/cue-lang/cue)
- [Go で CUE 言語(cuelang)使ってみた](https://zenn.dev/daifukuninja/articles/6e3c9c27ec6f6a)
- [cue 言語を利用して OpenAPI ファイルを生成する](https://zenn.dev/kawahara/articles/bc7c0851bea7d4)
