# React CSS

## Inline Styles
- このパターンは煩雑になりやすいのであまり使わない

```tsx
return (
  <div style={{ width: "100%", padding: "16px"}}>
    <p style={{ color: "blue", textAlign: "center"}}>Hello</p>
  </div>
)
```

```tsx
const containerStyle = {
  width: "100%",
  padding: "16px",
};
const textStyle = {
  color: "blue",
  textAlign: "center",
};

return (
  <div style={containerStyle}>
    <p style={textStyle}>Hello</p>
  </div>  
)
```

## CSS Modules
- `.css`や`.scss`ファイルを定義していくやり方で、デザイナーとの分業がしやすい
- React開発において、コンポーネント毎にCSSファイルを用意していく
- `npm install node-sass` が必要

- xxx.module.scss
```scss
.container {
  border: solid 1px #aaa;
  border-radius: 20px;
  padding: 8px;
  margin: 8px;
  display: flex;
  justify-content: space-around;
  align-items: center;
}
.title {
  margin: 0;
  color: #aaa;
}
.button {
  background-color: #ddd;
  border: none;
  padding: 8px;
  border-radius: 8px;
  &:hover {
    background-color: #aaa;
    color: #fff;
    cursor: pointer;
  }
}
```
- xxx.jsx
```tsx
import classes from './xxx.module.scss'

...

return (
  <div className={classes.container}>
    <p className={classes.title}>CSS Modules</p>
    <button className={classes.button}>Button</button>
  </div>
)
```

## styled components
- スタイルを適用したコンポーネントを定義する
- いまだによく使われているらしい
- `scss記法`が使える
- `npm install styled-components`

```tsx
import styled from "styled-components";

export const StyledComponents = () => {
  return (
    <SContainer>
      <STitle>styled componentsです</STitle>
      <SButton>ボタン</SButton>
    </SContainer>
  );
};

const SContainer = styled.div`
  border: solid 1px #aaa;
  border-radius: 20px;
  padding: 8px;
  margin: 8px;
  display: flex;
  justify-content: space-around;
  align-items: center;
`;
const STitle = styled.p`
  margin: 0;
  color: #aaa;
`;
const SButton = styled.button`
  background-color: #ddd;
  border: none;
  padding: 8px;
  border-radius: 8px;
  &:hover {
    background-color: #aaa;
    color: #fff;
    cursor: pointer;
  }
`;
```

## Styled JSX
- `CSS-in-JS`と呼ばれるライブラリ
- Next.jsに標準で組み込まれている
- あまり使われていないらしい
- デフォルトでは、`scss記法`は使用できない
- `npm install styled-jsx` が必要

```tsx
return (
  <>
    <div className="container">
      <p className="title">Styled JSXです</p>
      <button className="button">ボタン</button>
    </div>

    <style jsx>{`
      .container {
        border: solid 1px #aaa;
        border-radius: 20px;
        padding: 8px;
        margin: 8px;
        display: flex;
        justify-content: space-around;
        align-items: center;
      }
      .title {
        margin: 0;
        color: #aaa;
      }
      .button {
        background-color: #ddd;
        border: none;
        padding: 8px;
        border-radius: 8px;
      }
    `}</style>
  </>
);
```

## Emotion
- `CSS-in-JS` ライブラリ
- 幅広い使い方が用意されているが、混在させると可読性が低下する
  - Inline Styles
  - Styled JSX
  - styled components
- `@emotion/react`と`@emotion/styled`のinstallが必要

```tsx
/** コンポーネントファイルの中に CSS を書く方法 */
/** @jsxImportSource @emotion/react */
import { jsx, css } from "@emotion/react";
import styled from "@emotion/styled";

export const Emotion = () => {
  // scssの書き方がそのまま可能な書き方
  const containerStyle = css`
    border: solid 1px #aaa;
    border-radius: 20px;
    padding: 8px;
    margin: 8px;
    display: flex;
    justify-content: space-around;
    align-items: center;
  `;

  // インラインスタイルの書き方
  const titleStyle = css({
    margin: 0,
    color: "#aaa",
  });

  return (
    <div css={containerStyle}>
      <p css={titleStyle}>Emotion です </p>
      <SButton>ボタン</SButton>
    </div>
  );
};

// styled-componentsの書き方
const SButton = styled.button`
  background-color: #ddd;
  border: none;
  padding: 8px;
  border-radius: 8px;
  &:hover {
    background-color: #aaa;
    color: #fff;
    cursor: pointer;
  }
`;
```

## Tailwind CSS
- Utility firstな？CSSフレームワークで、2022年現在、人気が出てきている
- `CreateReactApp`の場合、Tailwindの動作に必要な`PostCSS`を上書くことができないため、`CRACO`が必要となる
- 設定が若干めんどくさい
- 一緒に`Headless UI`というコンポーネントライブラリを使うと開発が楽かも

```tsx
return (
  <div className="border border-gray-400 rounded-2xl p-2 m-2 flex justify-around items-center">
    <p className="m-0 text-gray-400">Tailwind CSSです</p>
    <button className="bg-gray-300 border-0 p-2 rounded-md hover:bg-gray-400 hover:text-white">
      ボタン
    </button>
  </div>
);
```
