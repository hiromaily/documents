# Component

## コンポーネント開発

1. Presentational Component

   - 見た目を実装するコンポーネントで、渡された props を元に UI を調整する

2. Container Component

   - デザインは実装せず、ビジネスロジックのみを担い、振る舞いを実装する
   - Hooks を持たせて、状態を使って表示内容を変える、API コールなどの副作用を実行するなど
   - Context を参照し、Presentational Component へ表示に必要なデータを渡す

   ```tsx
   import { useState, useCallback} from 'react'
   import { Button } from './button'

   // ポップアップを表示するためのフック
   const usePopup = () {
     // 与えられたテキストを表示するポップアップを出現させる関数
     const cb = useCallback((text: string) => {
       prompt(text)
     }, [])
     return cb
   }

   type CountButtonProps = {
     label: string
     maximum: number
   }

   // クリックされた回数を表示するボタンを表示するコンポーネント
   export const CountButton = (props: CountButtonProps) => {
     const { label, maximum } = props

     // アラートを表示させるためのフックを使う
     const displayPopup = usePopup()

     // カウントを保持する状態を定義する
     const [count, setCount] = useState(0)

     // ボタンが押されたときの挙動を定義する
     const onClick = useCallback(() => {
       // カウントを更新する
       const newCount = count + 1
       setCount(newCount)

       if (newCount >= maximum) {
         // アラートを出す
         displayPopup(`You have clicked ${newCount} times`)
       }
     }, [count, maximum])

     // 状態を元に表示に必要なデータを求める
     const disabled = count >= maximum
     const text = disabled
       ? 'Can not click any more'
       : `You have clicked ${count} times`

     // Presentational Componentを返す
     return {
       <Button disabled={disabled} onClick={onClick} label={label} text={text}>
     }
   }
   ```

## Atomic Design

5 つの階層に分かれた、デザインを構築する方法論で、React などのコンポーネント開発と相性がいい

- Atoms: 最小の要素 (ボタン、テキスト)
  - 特定のドメインに依存しない
- Molecules: 複数の Atoms を組み合わせて構築 (ラベル付きテキストボックス)
  - 1 つの役割を持った UI のみを実装
- Organisms: Molecules よりもより具体的な要素 (入力フォーム,ヘッダー）
  - ドメイン知識に依存したデータを受け取ったり、Context を参照したり、独自の振る舞いを持つことができる
- Templates: ページ全体のレイアウト
  - 複数の Organism 以下のコンポーネントを配置し、CSS でレイアウトする役割を担う
- Pages: ページそのもの
  - 状態の管理、router 関係の処理、API コールなどの副作用の実行、Context に値を渡すといった振る舞いを実装する

## styled-components によるスタイル実装

- `CSS in JS`と呼ばれるライブラリの 1 つで、JS 内に CSS を効率的に書くためのもので、コンポーネントにスタイルを適用するために使う
- コンポーネントと同じファイルでスタイルを実装する
- デフォルトでは、styled-components で定義したスタイルは描画時にスタイルを作成し、className をコンポーネントに渡す
- コンポーネント内の特定のコンポーネントにスタイルを適用したい場合は、class 属性（props に渡される className)を任意のコンポーネントに渡す
  - これは、Next.js のコンポーネントにスタイルを適用する場合に有用となる

### Next.js に styled-components を導入する

- install

  ```sh
  npm install --save styled-components
  npm install --save-dev @types/styled-components
  ```

- next.config.js

  ```js
  /** @type {import('next').NextConfig} */
  const nextConfig = {
    reactStrictMode: true,
    compiler: {
      styledComponents: true, //この設定が必要
    },
  };

  module.exports = nextConfig;
  ```

#### SSG/SSR 使用時にサーバーサイドでスタイルを適用させるための設定

- pages/\_document.tsx を用意
  - カスタムドキュメントと呼ばれる仕組みで、デフォルトで生成されるページの設定のうち、html, head, body 要素に関わる部分を上書きする
  - 以下では、スタイルを差し込む処理を追加している

```tsx
import Document, { DocumentContext } from "next/document";
import { ServerStyleSheet } from "styled-components";

// デフォルトのDocumentをMyDocumentで上書き
export default class MyDocument extends Document {
  static async getInitialProps(ctx: DocumentContext) {
    const sheet = new ServerStyleSheet();
    const originalRenderPage = ctx.renderPage;

    try {
      ctx.renderPage = () =>
        originalRenderPage({
          enhanceApp: (App) => (props) =>
            sheet.collectStyles(<App {...props} />),
        });

      // 初期値を流用
      const initialProps = await Document.getInitialProps(ctx);

      // initialPropsに加えて、styleを追加して返す。
      return {
        ...initialProps,
        styles: [
          // もともとのstyle
          initialProps.styles,
          // styled-componentsのstyle
          sheet.getStyleElement(),
        ],
      };
    } finally {
      sheet.seal();
    }
  }
}
```

#### pages/index.tsx に適用する例

- `styled.<要素名>`で要素を指定し、その直後に`テンプレート文字列`を書く
- `テンプレート文字列`の中でスタイルを定義する
- これにより、スタイルが適用された`要素`ができあがる

```tsx
import type { NextPage } from "next";
import Head from "next/head";
import styles from "../styles/Home.module.css";
import styled from "styled-components";

// スタイルが適用された要素
const H1 = styled.h1`
  color: red;
`;

const Home: NextPage = () => {
  return (
    <div className={styles.container}>
      ...
      <main className={styles.main}>
        <H1 className={styles.title}>
          Welcome to <a href="https://nextjs.org">Next.js!</a>
        </H1>
      </main>
    </div>
  );
};

export default Home;
```

#### styled-components を使ってコンポーネントを実装する

```tsx
import { NextPage } from "next";
import styled from "styled-components";

// スタイルが適用された要素だが、コンポーネントにもなりえる
const Badge = styled.span`
  padding: 8px 16px;
  font-weight: bold;
  text-align: center;
  color: white;
  background: red;
  border-radius: 16px;
`;

const Page: NextPage = () => {
  return <Badge>Hello World!</Badge>;
};

export default Page;
```

#### props を使って、外部からスタイルを制御する

```tsx
import { NextPage } from "next";
import styled from "styled-components";

type ButtonProps = {
  color: string;
  backgroundColor: string;
};

// 文字色と背景色がpropsから変更可能なボタンコンポーネント
// 型引数にpropsの型を渡す
const Button = styled.button<ButtonProps>`
  /* color, background, border-colorはpropsから渡す */
  color: ${(props) => props.color};
  background: ${(props) => props.backgroundColor};
  border: 2px solid ${(props) => props.color};

  font-size: 2em;
  margin: 1em;
  padding: 0.25em 1em;
  border-radius: 8px;
  cursor: pointer;
`;

const Page: NextPage = () => {
  return (
    <div>
      {/* 赤色の文字で透明な背景のボタンを表示 */}
      <Button backgroundColor="transparent" color="#FF0000">
        Hello
      </Button>
      {/* 白色の文字で青色の背景のボタンを表示 */}
      <Button backgroundColor="#1E90FF" color="white">
        World
      </Button>
    </div>
  );
};

export default Page;
```

#### mixin を使う

- styled-components の`mixin`では CSS の定義を再利用できる

```tsx
import { NextPage } from "next";
import styled, { css } from "styled-components";

// 赤色のボーダーを表示するスタイル
const redBox = css`
  padding: 0.25em 1em;
  border: 3px solid #ff0000;
  border-radius: 10px;
`;

// 青色文字を表示するスタイル
const font = css`
  color: #1e90ff;
  font-size: 2em;
`;

// 赤色ボーダーと青色文字のスタイルをそれぞれ適用し、背景が透明なボタンコンポーネント
const Button = styled.button`
  background: transparent;
  margin: 1em;
  cursor: pointer;

  ${redBox}
  ${font}
`;

// 青色文字のスタイルを継承し、ボールドでテキストを表示するコンポーネント
const Text = styled.p`
  font-weight: bold;

  ${font}
`;

const Page: NextPage = () => {
  return (
    <div>
      {/* 青色文字で赤色ボーダーのボタンを表示 */}
      <Button>Hello</Button>
      {/* 青色文字のテキストを表示 */}
      <Text>World</Text>
    </div>
  );
};

export default Page;
```

#### スタイルを継承する

- スタイルを再利用したいとき、違う方法として、ある要素のスタイルを継承することも有用

```tsx
import { NextPage } from "next";
import styled from "styled-components";

// 青いボールド文字を表示するコンポーネント
const Text = styled.p`
  color: blue;
  font-weight: bold;
`;

// Textを継承し、ボーダーのスタイルを加えたコンポーネント
const BorderedText = styled(Text)`
  padding: 8px 16px;
  border: 3px solid blue;
  border-radius: 8px;
`;

const Page: NextPage = () => {
  return (
    <div>
      <Text>Hello</Text>
      <BorderedText>World</BorderedText>
    </div>
  );
};

export default Page;
```

#### スタイルを別コンポーネントで使用する

- props の`as`に使いたい要素名を指定するとその要素で表示できる

```tsx
import { NextPage } from "next";
import styled from "styled-components";

// 青色のテキストを表示するコンポーネント
const Text = styled.p`
  color: #1e90ff;
  font-size: 2em;
`;

const Page: NextPage = () => {
  return (
    <div>
      {/* 青色のテキストを表示 */}
      <Text>World</Text>
      {/* 青色のリンクを表示　*/}
      <Text as="a" href="/">
        Go to index
      </Text>
    </div>
  );
};

export default Page;
```

#### 特定のコンポーネント(Next.js のコンポーネントなど）にスタイルを使用する

- コンポーネント内の特定のコンポーネントにスタイルを適用したい場合は、class 属性（props に渡される className)を任意のコンポーネントに渡す

```tsx
import { NextPage } from "next";
import Link, { LinkProps } from "next/link";
import styled from "styled-components";

type BaseLinkProps = React.PropsWithChildren<LinkProps> & {
  className?: string;
  children: React.ReactNode;
};

// Next.jsのリンクにスタイルを適用するためのヘルパーコンポーネント
// このコンポーネントをstyled-componentsで使用すると、
// 定義したスタイルに対応するclassNameがpropsとして渡される
// このclassNameをa要素に渡す
const BaseLink = (props: BaseLinkProps) => {
  const { className, children, ...rest } = props;
  return (
    <Link {...rest}>
      <a className={className}>{children}</a>
    </Link>
  );
};

const StyledLink = styled(BaseLink)`
  color: #1e90ff;
  font-size: 2em;
`;

const Page: NextPage = () => {
  return (
    <div>
      {/* 青色のリンクを表示する */}
      <StyledLink href="/">Go to Index</StyledLink>
    </div>
  );
};

export default Page;
```

#### Theme

- styled-components の`ThemeProvider`を使うことでテーマを設定できる。
- これは使用する色や文字、・スペースの大きさを別途定義しておき、props でスタイルを設定するときに、値を参照できる昨日
- Theme を利用するとアプリ全体で同じスタイルを使用でき、デザインの一貫性を保てるし、スタイルの変更も一括して可能

1. まず、theme.ts を作成し、Theme を定義

   ```ts
   export const theme = {
     space: ["0px", "4px", "8px", "16px", "24px", "32px"],
     colors: {
       white: "#ffffff",
       black: "#000000",
       red: "#ff0000",
     },
     fontSizes: ["12px", "14px", "16px", "18px", "20px", "23px"],
     fonts: {
       primary: `arial, sans-serif`,
     },
   };
   ```

2. 作成した Theme を`ThemeProvider`に渡す。それぞれのページコンポーネントが`Context`経由で参照できるようにする

   - `pages/_app`はページの処理かのために用いられ、`カスタムApp`と呼ばれる。
   - 全ページに共通する処理をページ初期化時に追加するもの

   ```tsx
   import "../styles/globals.css";
   import type { AppProps } from "next/app";
   import { ThemeProvider } from "styled-components";
   import { theme } from "../theme";

   function MyApp({ Component, pageProps }: AppProps) {
     // styled-componentsでテーマを使用するためにThemeProviderを置く
     return (
       <ThemeProvider theme={theme}>
         <Component {...pageProps} />
       </ThemeProvider>
     );
   }

   export default MyApp;
   ```

3. Theme で定義した値を使用するには、props の theme オブジェクトを参照する

   ```tsx
   import { NextPage } from "next";
   import styled from "styled-components";

   const Text = styled.span`
     /* themeから値を参照してスタイルを適用 */
     color: ${(props) => props.theme.colors.red};
     font-size: ${(props) => props.theme.fontSizes[3]};
     margin: ${(props) => props.theme.space[2]};
   `;

   const Page: NextPage = () => {
     return (
       <div>
         <Text>Themeから参照した色を使用しています</Text>
       </div>
     );
   };

   export default Page;
   ```

## [WIP] コンポーネントの UnitTest
