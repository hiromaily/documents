# GitHub リポジトリ: `microsoft/typescript-go`

**[microsoft/typescript-go](https://github.com/microsoft/typescript-go)**リポジトリは、TypeScript のネイティブポートを Go プログラミング言語で開発するためのステージングエリア。

## 概要

- **目的**: このリポジトリは、`Go言語を使用してTypeScriptのネイティブバージョンを作成する`ための開発プラットフォームとして機能する。
- **アクティブな開発**: プロジェクトは現在も活発に開発中であり、安定したリリースや公開されたアーティファクトはまだない。

## 主な特徴

- **使用されている言語**:
  - Go (98.9%)
  - その他 (1.1%)
- **現在の機能**:
  - **プログラム作成**: ライブラリ、ターゲット、参照、インポート、ファイル管理の読み取り機能。
  - **パース/スキャン**: ソーステキストを読み取り、構文エラーを特定する機能。
  - **型解決**: 型を正確に解決し、TypeScript 5.8 と一致する。
  - **型チェック**: 関数、クラス、ステートメントのエラーを特定し、TypeScript 5.8 と一致する。
- **進行中の機能 (2025/03 現在)**:
  - **JavaScript 特有の推論および JS Doc**: まだ実装されていない
  - **JSX サポート**: 準備中
  - **宣言のエミット**: 今後実装予定
  - **インクリメンタルビルドおよびウォッチモード**: プロトタイプ段階で、機能は限定的。

## プロジェクトをビルドして実行する方法

1. **前提条件**:

   - Go バージョン 1.24 以上
   - `Node.js`と`npm`

2. **各コマンド**:

   ```sh
   # サブモジュールを含めてcloneする
   git clone --recurse-submodules https://github.com/microsoft/typescript-go.git
   # or, サブモジュールを初期化
   git submodule update --init

   # 依存関係をインストール
   npm ci

   # `hereby` を使用してプロジェクトをビルド (option)
   # herebyはnode.jsのtaskランナー
   hereby build

   # TypeScript Go コンパイラの実行 (ビルドしたコンパイラを実行)
   ./built/local/tsgo
   # 通常の TypeScript コンパイラとより高い再現度で実行する
   ./tsgo tsc [flags]
   ```

3. **LSP プロトタイプのテスト**:
   - Visual Studio Code でリポジトリを開く:
   - `.vscode/launch.template.json`を`.vscode/launch.json`にコピーして、起動設定を行う。
   - デバッグを開始する（F5）。

## 今後の計画

長期的な目標は、このリポジトリの内容をメインの**microsoft/TypeScript**リポジトリに統合すること。

## 議論

[Why Go?](https://github.com/microsoft/typescript-go/discussions/411)

言語選択は常に注目を集めるトピックです。最近も過去の調査も含めて多くの言語オプションを広範囲に評価しました。また、一部のコンポーネントをネイティブ言語で書き、コアの型チェックアルゴリズムはJavaScriptで残すハイブリッドアプローチも検討しました。異なる言語で異なるデータ表現を試すために複数のプロトタイプを作成し、swc、oxc、esbuildのような既存のネイティブTypeScriptパーサーが使用するアプローチを深掘り調査しました。多くの言語が新規にコードを書く場合に適している一方、Goが複数の基準で最も良い結果をもたらしました。

最も重要な点は、新しいコードベースを既存のものと可能な限り互換性を保つ必要があることです。両方のコードベースをしばらくの間維持する予定です。構造が似ているコードベースを提供できる言語は、変更を簡単に移植できるので大きな利点があります。対照的に、メモリ管理、データ構造、多態性、遅延評価などを根本的に再考する必要がある言語は、新規に書き直す場合には適しているかもしれませんが、既存の動作や最適化を保つための移植には適していません。GoはTypeScriptコードベースの既存のコーディングパターンと非常に類似しており、移植作業を容易にします。

さらに、Goはメモリレイアウトとアロケーションの制御に優れており、コードベース全体がメモリ管理に常に注意を払う必要がありません。これにはガベージコレクタが含まれますが、わたしたちのコードベースではそのデメリットは特に顕著ではありません。バッチコンパイルでは、プロセスの終了時にガベージコレクションを完全に回避でき、非バッチシナリオでも、ほとんどの初期アロケーションはプログラムの全期間中生き残ります。したがって、Goのモデルはコードベースの複雑さを減少させる大きな利点をもたらし、実際のランタイムコストをほとんど負担しません。

また、わたしたちは大量のグラフ処理、特に多態性ノードを含む木構造の上下でのトラバースを行っています。Goはこれをエルゴノミックにするのが非常に上手です。

いくつかの弱点を認めると、GoのインプロセスJS相互運用性は他の選択肢に比べて劣りますが、これを緩和するための今後の計画があります。意図的なAPI設計に移行し、相互運用性も考慮することで、これらの大きなパフォーマンス向上を維持しつつエコシステムを前進させることができます。

## References

- [TypeScript の Go 移植に備えて知っておくべきこと](https://zenn.dev/dinii/articles/typescript-go)

### [But Why Did Microsoft Port TypeScript to Go Instead of Rust?](https://analyticsindiamag.com/ai-features/but-why-did-microsoft-port-typescript-to-go-instead-of-rust/)

MicrosoftがTypeScriptコンパイラをRustではなくGoに移植する理由についての議論が行われている。
MicrosoftはTypeScriptの移植においてGoを選んだ理由は、技術的な適合性と移行の容易さにある。

#### 移植の背景

- **移植の目的**: TypeScriptコンパイラとツールセットをGoに移植することで、異なるコードベース間で10倍のコンパイル速度を実現することを目指している。
- **開発者の反応**: 多くの開発者はこの発表を称賛したが、一部はRustではなくGoを選んだことに失望を表明した。

#### Microsoftの見解

- **Ryan Cavanaughの説明**: TypeScriptのリード開発者であるCavanaughは、Rustも選択肢として考慮されたが、ポータビリティが重要な制約であったと述べている。Rustではパフォーマンスや使いやすさにおいて「受け入れがたい」トレードオフがあったため、Goが選ばれた。
- **Goの利点**: Goは自動的にメモリを管理するガーベジコレクションを備えており、JavaScriptコードのポートに適しているとされている。

#### 技術的な課題

- **Rustの制約**: Rustは循環データ構造に対する厳しい制限があり、TypeScriptコンパイラが依存している抽象構文木（AST）などの構造を扱うのが難しいと指摘されている。
- **移植の選択肢**: Cavanaughは、Rustでの完全な書き直しは「数年」かかり、互換性のないバージョンになる可能性があるため、Goでの移植を選択したと述べている。

#### 結論

- **移行の容易さ**: TypeScriptからJavaScriptに移行する際、Goへの移行はRustよりも簡単であるとCavanaughとTypeScriptのリードアーキテクトであるAnders Hejlsbergは強調している。Goはシンプルで、複雑な言語ではないため、移行がスムーズに行えるとされている。
