# Next.js
The React Framework for Production

- [Next.js](https://nextjs.org/)
- [Docs](https://nextjs.org/docs/getting-started)
- [Docs (ja)](https://nextjs-ja-translation-docs.vercel.app/docs/getting-started)
## Create Next App
- [Docs](https://nextjs.org/docs/api-reference/create-next-app)
```
npx create-next-app@lates
 or
npx create-next-app@latest --ts
```
- [next.js/example](https://github.com/vercel/next.js/tree/canary/examples)をtemplateとすることもできる。
```
npx create-next-app --example https://github.com/vercel/next.js/tree/canary/examples/hello-world-esm app-name
```

## Functionality
### Image Component and Image Optimization
- [Docs](https://nextjs.org/docs/basic-features/image-optimization)

- Next.js Image コンポーネント next/image は、HTMLの <img> 要素を拡張し、モダンウェブ用に進化させたもの
- このコンポーネントには、優れた`Core Web Vitals`を実現するための、さまざまなパフォーマンスの最適化が組み込まれている

### Internationalized Routing
- [Docs](https://nextjs.org/docs/advanced-features/i18n-routing)

- Next.jsは`v10.0.0`から国際化ルーティングをビルトインでサポートしている
- localeのリスト、デフォルトlocale、ドメイン固有localeを指定すると、Next.jsが自動的にルーティングを処理する
- `i18n`ルーティングのサポートは、routesとlocaleの解析を効率化することで、`react-intl`, `react-i18next`, `lingui`, `rosetta`, `next-intl` などの既存の`i18n`ライブラリソリューションを補完することが現在の目的。

### Real Data. Real Performance
- [Analytics](https://nextjs.org/analytics)


### Zero Config
- [Docs](https://nextjs.org/docs/getting-started)

- 自動コンパイルとバンドル。最初からプロダクション用に最適化されている
- これにより、webpack等の設定の必要がない

### Hybrid: SSG and SSR
- [Docs](https://nextjs.org/docs/basic-features/data-fetching/overview)

- Next.jsのData fetchingでは、アプリケーションのユースケースに応じて、さまざまな方法でコンテンツをレンダリングすることができる。
- `Server-side Rendering`や`Static Generation`よるpre-rendering
- `Incremental Static Generation`による実行時のコンテンツの更新や生成など

### Incremental Static Regeneration
- [Docs](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration)

- Next.jsでは、サイトを構築した後に静的ページを作成したり更新したりすることができる。
- `Incremental Static Regeneration` (ISR) を利用すると、サイト全体を再構築することなく、ページ単位で静的生成を行うことができる
- また、静的ページの利点を維持しながら、数百万ページまで拡張することができる。

### Fast Refresh
- [Docs](https://nextjs.org/docs/basic-features/fast-refresh)

- Reactコンポーネントに対する編集を即座にフィードバックするNext.jsの機能
- 9.4以降のすべてのNext.jsアプリケーションで、デフォルトで有効になっている
- コンポーネントの状態を失うことなく、ほとんどの編集が1秒以内に表示されるようになる

### File-system Routing
- [Docs](https://nextjs.org/docs/routing/introduction)

- `Pages`という概念をベースにしたファイルシステム・ルータ
- `pages`ディレクトリにファイルが追加されると、自動的にそのファイルがルートとして利用できるようになる
- `pages`ディレクトリの中にあるファイルは、もっとも一般的なパターンを定義するために利用することができる

### API Routes
- [Docs](https://nextjs.org/docs/api-routes/introduction)

- API routesは、Next.jsでAPIを構築するためのソリューション
- `pages/api`フォルダ内のファイルは、`/api/*`にマップされ、ページの代わりに`APIエンドポイント`として扱われる
- これらはサーバーサイドのみのバンドルであり、クライアントサイドのバンドルサイズを増やすことはない
- 例えば、以下のAPIルート `pages/api/user.js` は、ステータスコード 200 の json レスポンスを返す
```
export default function handler(req, res) {
  res.status(200).json({ name: 'John Doe' })
}
```

### Built-In CSS Support
- [Docs](https://nextjs.org/docs/basic-features/built-in-css-support)

- Next.jsでは、JavaScriptファイルからCSSファイルをインポートすることができる

### Middleware
- [Docs](https://nextjs.org/docs/advanced-features/middleware)

- Middlewareは、リクエストが完了する前にコードを実行し、受信したリクエストに基づいて、レスポンスを変更することができるようにするもの
  - 書き換え、
  - リダイレクト、
  - ヘッダーの追加、
  - クッキーの設定
- キャッシュされたコンテンツの前に実行されるので、静的なファイルやページをパーソナライズすることができる
- ミドルウェアの一般的な例としては、認証、A/Bテスト、ローカライズページ、ボット対策などが挙げられる
- ローカライズページについては、まず国際化ルーティングから始め、より高度なユースケースを実現するためにミドルウェアを実装することができる

## Rendering手法
- SSG: Static Site Generation ... 静的サイト生成
  - ビルド時に`getStaticProps`という関数が呼ばれ、APIでデータを取得して、レンダリングした結果を静的ファイルとして生成する
  - ページにアクセスがあった場合、生成された静的ファイルをレスポンスとして返す
  - リアルタイム性が求められるコンテンツには適さない
  - パフォーマンスに優れているため、SSGが推奨されている
- CSR: Client Side Rendering
  - ブラウザで初期描画後、非同期で取得したデータをもとにレンダリングを行う
  - SEOにあまり有効ではない
  - SSG, SSR, ISRと組み合わせて利用される
  - 初期描画がそこまで重要ではなく、リアルタイム性が重要なページに適している
- SSR: Server Side Rendering
  - ページへのアクセスがある度にサーバーで`getServerSideProps`関数を呼出し、サーバー側でレンダリングした結果をクライアントに返す
  - そのため、動的データであっても、SEOに有効
  - 低レイテンシーに陥る可能性がある
- ISR: Incremental Static Regeneration ... インクリメンタル静的再生成
  - SSGと同じように事前ビルドされた静的ファイルをレスポンスとして返すが、このデータに有効期限を設定でき、有効期限が切れたあとはバックグラウンドで再度`getStaticProps`を実行してページをレンダリングし、保存されているデータを更新する
  - SSGとSSRの中間のようなレンダリング手法

### どのようにRendering手法を切り替えるか？
- ファイル内部でコンポーネントの他に実装する関数や関数の返す値によって、レンダリング手法が切り替わる
- 主な要素はデータ取得の関数
  - SSG: getStaticProps ... ビルド時にデータを取得
  - SSR: getServerSideProps ... ユーザーのリクエスト時
  - ISR: getStaticProps(revalidateを返す)
- ビルド時の結果から確認できる
- 

## Page
- `Pages`ディレクトリ以下に配置したtsxなどのファイルは、1つのファイルが1つのページに対応する
```
import { NextPage } from 'next'
import Head from 'next/head';

const Page = () => {
  const title = 'React Book'

  return (
    <TitleContext.Provider value={title}>
      <Header />
    </TitleContext.Provider>
  )
}

export default Page
```
- ここでexportする関数とファイル名は同一の名前にすること

### SSGによるPage実装
- `getStaticProps()`を定義し、exportする
- `getStaticProps()`の引数に`context`が渡されるが、これはReactの`context`ではない。
```
# contextのparameter
- params
- locale
- locales
- defaultLocale
- preview
- previewData
```

#### Basic
```tsx
import { GetStaticProps, NextPage, NextPageContext } from "next";
import Head from "next/head";

// ページコンポーネントのpropsの型定義
type SSGProps = {
  message: string;
};

// SSGはgetStaticPropsが返したpropsを受け取ることができる
// NextPage<SSGProps>はmessage: stringのみを受け取って生成されるページの型
// Next.jsのページコンポーネントや関数の型は https://nextjs.org/learn/excel/typescript/nextjs-types もご参照ください
const SSG: NextPage<SSGProps> = (props) => {
  const { message } = props;

  return (
    <div>
      <Head>
        <title>Static Site Generation</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main>
        <p>このページは静的サイト生成によってビルド時に生成されたページです</p>
        <p>{message}</p>
      </main>
    </div>
  );
};

// getStaticPropsはビルドに実行される
// GetStaticProps<SSGProps>はSSGPropsを引数にとるgetStaticPropsの型
export const getStaticProps: GetStaticProps<SSGProps> = async (context) => {
  const timestamp = new Date().toLocaleString();
  const message = `${timestamp} にgetStaticPropsが実行されました`;
  console.log(message);
  return {
    // ここで返したpropsを元にページコンポーネントを描画する
    props: {
      message,
    },
  };
};

export default SSG;
```

#### Blogなど、表示するデータが違うPageにおけるSSG
- Dynamic Routing機能を使って、path parameterを使って、複数ページを1つのファイルで生成できる
- Dynamic Routingの要素は以下の通り
  - [parameter].tsxのような`[]`で囲んだファイル名
  - `getStaticProps`とあわせて`getStaticPath`を利用する
- `getStaticPath`実行後、`getStaticProps`が実行される
- `getStaticPath`は、生成したいpageのpath parameterの組み合わせ(paths)とfallbackを返す
- `fallback`は`getStaticPath`が生成するページが存在しない場合の処理を記載
- `pages/posts`ディレクトリを作成し、`[id].tsx`というファイルを作成する

```tsx
// 型を利用するためにインポート
import { GetStaticPaths, GetStaticProps, NextPage } from 'next'
import Head from 'next/head'
import { useRouter } from 'next/router' // next/routerからuseRouterというフックを取り込む
import { ParsedUrlQuery } from 'querystring'

type PostProps = {
  id: string
}

const Post: NextPage<PostProps> = (props) => {
  const { id } = props
  // routing情報取得のためのHook
  // router.push でページ遷移にも使える
  const router = useRouter()

  if (router.isFallback) {
    // フォールバックページ向けの表示を返す
    return <div>Loading...</div>
  }

  return (
    <div>
      <Head>
        <title>Create Next App</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main> <p> このページは静的サイト生成によってビルド時に生成されたページです。
        </p>
        <p>{`/posts/${id}に対応するページです`}</p>
      </main>
    </div>
  )
}

// getStaticPathsは生成したいページのパスパラメータの組み合わせを返す
// このファイルはpages/posts/[id].tsxなので、パスパラメータとしてidの値を返す必要がある
export const getStaticPaths: GetStaticPaths = async () => {
  // それぞれのページのパスパラメータをまとめたもの
  const paths = [
    {
      params: {
        id: '1',
      },
    },
    {
      params: {
        id: '2',
      },
    },
    {
      params: {
        id: '3',
      },
    },
  ]

  // fallbackをfalseにすると、pathsで定義されたページ以外は404ページを表示する
  return { paths, fallback: false }
}

// パラメータの型を定義
interface PostParams extends ParsedUrlQuery {
  id: string
}

// getStaticPaths実行後にそれぞれのパスに対してgetStaticPropsが実行される
export const getStaticProps: GetStaticProps<PostProps, PostParams> = async (context) => {
  return {
    props: {
      id: context.params!['id'],
    },
  }
}

export default Post
```

### SSRによるPage実装
- `getServerSideProps()`を定義し、exportする
- `getServerSideProps()`引数の`context`では、`getStaticProps`の`context`で参照できるデータに加え、リクエスト情報などを参照できる
```
# contextのparameter
- req
- res
- resolvedUrl
- query
```

#### Code
```tsx
import { GetServerSideProps, NextPage } from 'next'
import Head from 'next/head'

type SSRProps = {
  message: string
}

const SSR: NextPage<SSRProps> = (props) => {
  const { message } = props

  return (
    <div>
      <Head>
        <title>Create Next App</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main>
        <p>
          このページはサーバーサイドレンダリングによってアクセス時にサーバーで描画されたページです。
        </p>
        <p>{message}</p>
      </main>
    </div>
  )
}

// getServerSidePropsはページへのリクエストがある度に実行される
export const getServerSideProps: GetServerSideProps<SSRProps> = async (
  context
) => {
  const timestamp = new Date().toLocaleString()
  const message = `${timestamp} にこのページのgetServerSidePropsが実行されました`
  console.log(message)

  return {
    props: {
      message,
    },
  }
}

export default SSR
```

### ISRによるPage実装
- `revalidate`を返す`getStaticProps`を使うのだが、`revalidate`を返すとその値が有効期間となり、有効期間が過ぎたページは再生成される

```tsx
import { GetStaticPaths, NextPage, GetStaticProps } from 'next'
import Head from 'next/head'
import { useRouter } from 'next/router'

type ISRProps = {
  message: string
}

// ISRPropsを受け付けるNextPage（ページ）の型
const ISR: NextPage<ISRProps> = (props) => {
  const { message } = props

  const router = useRouter()

  if (router.isFallback) {
    // フォールバック用のページを返す
    return <div>Loading...</div>
  }

  return (
    <div>
      <Head>
        <title>Create Next App</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main>
        <p>このページはISRによってビルド時に生成されたページです。</p>
        <p>{message}</p>
      </main>
    </div>
  )
}

export const getStaticProps: GetStaticProps<ISRProps> = async (context) => {
  const timestamp = new Date().toLocaleString()
  const message = `${timestamp} にこのページのgetStaticPropsが実行されました`

  return {
    props: {
      message,
    },
    // ページの有効期間を秒単位で指定
    revalidate: 60,
  }
}

export default ISR
```
