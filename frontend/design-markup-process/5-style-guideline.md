# 5. スタイルガイドの作成

スタイルガイドの作成は、プロジェクト全体で一貫性のあるデザインとユーザーエクスペリエンスを提供するためのステップ。
スタイルガイドの作成は、プロジェクトの成功に不可欠な一貫性と効率を提供する。適切に設計されたスタイルガイドは、開発チームとデザインチームの間のコラボレーションを容易にし、ユーザーにとって統一されたエクスペリエンスを提供する助けとなる。継続的な更新とメンテナンスを通じて、スタイルガイドを生きたドキュメントとして機能させることが重要。

## 1. なぜスタイルガイドが重要なのか？

スタイルガイドは、次のような利点を提供する：

- **一貫性の確保**: 全てのデザイン要素が同じルールに従うことで、一貫性のあるビジュアルとユーザーエクスペリエンスを実現。
- **効率の向上**: 開発者とデザイナー間のコミュニケーションがスムーズになる。新しいメンバーも早くプロジェクトに慣れる。
- **メンテナンスの容易さ**: デザインやスタイルの変更が容易に反映される。

## 2. スタイルガイドの主な要素

### カラーパレット

- **主要色**（Primary Colors）：ブランドの主な色。
- **副次色**（Secondary Colors）：補完的な色。
- **状態色**（Status Colors）：エラーメッセージ、成功メッセージなどに使用する色。
- **色のトークン**：色を変数として定義する。例：

```scss
$primary-color: #3498db;
$secondary-color: #2ecc71;
$error-color: #e74c3c;
```

### タイポグラフィ

- **フォントファミリー**：使用するフォントのセット。
- **フォントサイズ**：さまざまなテキスト要素のサイズ（例えば、見出し、本文、キャプション）。
- **ラインハイトとレター間隔**：行間と文字間の設定。
- **フォントウエイト**：太字、普通、軽いなどの設定。

```scss
$font-family-primary: "Helvetica, Arial, sans-serif";
$font-size-base: 16px;
$line-height-base: 1.5;
$font-weight-normal: 400;
$font-weight-bold: 700;
```

### スペーシングとレイアウト

- **マージンとパディング**：コンポーネント間のスペース。
- **グリッドとブレークポイント**：レスポンシブデザインの設定。

```scss
$spacing-small: 8px;
$spacing-medium: 16px;
$spacing-large: 32px;

$grid-columns: 12;
$breakpoint-mobile: 576px;
$breakpoint-tablet: 768px;
$breakpoint-desktop: 992px;
```

### ボタンのスタイル

- 通常時、ホバー時、アクティブ時などのスタイル。
- 色、サイズ、ボーダー、シャドウなど。

```jsx
const Button = styled.button`
  background-color: ${(props) => (props.primary ? "#3498db" : "#2ecc71")};
  color: #fff;
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: 4px;
  cursor: pointer;

  &:hover {
    background-color: ${(props) => (props.primary ? "#2980b9" : "#27ae60")};
  }
`;
```

### フォームエレメントのスタイル

- 入力フィールド、セレクトボックス、チェックボックス、ラジオボタンなどのスタイル。

```scss
input[type="text"],
textarea {
  padding: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 4px;
}

input[type="checkbox"],
input[type="radio"] {
  margin-right: 0.5rem;
}
```

## 3. スタイルガイドの実装

### コンポーネントライブラリの構築

- 共通のスタイルが適用された再利用可能なコンポーネントを作成する。
- 例：ボタン、カード、モーダル、ナビゲーションバーなど。

### デザインシステムの整備

- Figma のデザインシステム機能を使用して、プロジェクト全体の要素を統一。
- Figma Tokens などを利用して、デザインとコードのブリッジを作成しやすくする。

### スタイルシートの構造化

- SCSS や CSS Modules、Styled-components などを利用してスタイルを整理。
- ベストプラクティスとして、BEM（Block Element Modifier）や OOCSS（Object Oriented CSS）などの命名規則を使用する。

```scss
// BEM法命名
.button {
  &--primary {
    background-color: $primary-color;
  }

  &--secondary {
    background-color: $secondary-color;
  }

  &__icon {
    margin-right: 8px;
  }
}
```

## 4. ドキュメント化

### スタイルガイドのドキュメント

- デザインチームと開発チームが共有できるスタイルガイドのドキュメントをオンラインで維持。例えば、Storybook を使用する。

### 使用例とガイドライン

- 各コンポーネントの使用例と、それがどのように使われるべきかのガイドラインを明示する。

```jsx
import { storiesOf } from "@storybook/react";
import React from "react";
import Button from "./Button";

storiesOf("Button", module)
  .add("Primary", () => <Button primary>Primary Button</Button>)
  .add("Secondary", () => <Button>Secondary Button</Button>);
```

## 5. 継続的な更新とメンテナンス

### フィードバックループ

- デザイナーと開発者からのフィードバックを定期的に受け取り、スタイルガイドを更新する。
- 新しい要素やコンポーネントが追加される際には、スタイルガイドにそれらを反映させる。

### バージョン管理

- スタイルガイド自体もバージョン管理システム（例：Git）で管理し、変更履歴を追跡可能にする。
