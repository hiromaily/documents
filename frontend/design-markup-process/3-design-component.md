# 3. コンポーネントの設計

Figma のデザインを React コンポーネントとして設計する際の詳細なプロセスを以下の通り。これはコードの再利用性、保守性、スケーラビリティを確保するために必要なステップ。

## 1. コンポーネントの識別

### 基本コンポーネントと複合コンポーネント

- **基本コンポーネント**: ボタン、入力フィールド、アイコンなど、単一の機能を持つ小さなコンポーネント。
- **複合コンポーネント**: カード、ナビゲーションバー、モーダルなど、複数の基本コンポーネントを組み合わせたもの。

### 再利用可能性の高いコンポーネントの特定

- Figma のデザインを確認し、どの部分が他の部分でも利用されるかを特定する。例えば、同じスタイルのボタンが複数のページで使われる場合、それを再利用可能なコンポーネントとして設計する。

## 2. コンポーネントの分割

- デザインをトップダウンで分割することが効果的。ページ全体 → セクション → コンポーネントという階層を意識する。
- 例: ページ > ヘッダー > ロゴ、ナビゲーションリンク

## 3. コンポーネントの作成

#### 基本コンポーネントの作成

- シンプルなコンポーネントから始める。例えば、Button コンポーネントを作成する場合：

```jsx
import React from "react";
import PropTypes from "prop-types";
import "./Button.css"; // スタイルファイルをインポート

const Button = ({ text, onClick, type = "button", className }) => (
  <button type={type} onClick={onClick} className={`button ${className}`}>
    {text}
  </button>
);

Button.propTypes = {
  text: PropTypes.string.isRequired,
  onClick: PropTypes.func,
  type: PropTypes.oneOf(["button", "submit", "reset"]),
  className: PropTypes.string,
};

export default Button;
```

### 複合コンポーネントの作成

- 基本コンポーネントを組み合わせて複合コンポーネントを作成する。例えば、Card コンポーネント：

```jsx
import React from "react";
import PropTypes from "prop-types";
import "./Card.css";
import Button from "./Button";

const Card = ({ title, content, buttonText, onButtonClick }) => (
  <div className="card">
    <h2>{title}</h2>
    <p>{content}</p>
    <Button text={buttonText} onClick={onButtonClick} />
  </div>
);

Card.propTypes = {
  title: PropTypes.string.isRequired,
  content: PropTypes.string.isRequired,
  buttonText: PropTypes.string.isRequired,
  onButtonClick: PropTypes.func.isRequired,
};

export default Card;
```

## 4. コンポーネント間のデータフロー

- 親コンポーネントが子コンポーネントに必要なデータや関数を props として渡す。
- 状態管理が必要な場合、useState フックやコンテキスト API、Redux などを利用して適切に状態を管理する。

## 5. スタイルの適用

### CSS または CSS-in-JS の選択

- 通常の CSS、Sass、CSS Modules、Styled-components など、プロジェクトに適した方法を選ぶ。
- 例：Styled-components で Button のスタイルを定義する場合：

```jsx
import styled from "styled-components";

const StyledButton = styled.button`
  background-color: #4caf50;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border: none;
`;

const Button = ({ text, onClick }) => (
  <StyledButton onClick={onClick}>{text}</StyledButton>
);

export default Button;
```

## 6. コンポーネントライブラリの構築

- 共通コンポーネントを`components`フォルダに集めてコンポーネントライブラリを構築する。
- 名前空間やファイル構造を整理し、容易にアクセスできるようにする。

## 7. ドキュメント化

- 新しく作成したコンポーネントについて、使用方法やパラメータをドキュメントに記載する。Storybook などのツールを使うと、視覚的なドキュメント化が便利。

## 8. テストとデバッグ

- 各コンポーネントが期待通りに動作するかを確かめるために、ユニットテストやスナップショットテストを実施する。Jest や React Testing Library を使用する。

以上のステップを通じて、Figma のデザインから効率的で再利用可能な React コンポーネントを設計できるようになる。コンポーネントの適切な設計は、プロジェクトのメンテナンス性と拡張性を大幅に向上させる。
