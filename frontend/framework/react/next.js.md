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
 or
npx create-next-app <app-name> --ts --use-npm
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
  - デメリットは、ユーザーごとにHTMLを生成させることになり、キャッシュがきかないため、UXを損なう
- ISR: Incremental Static Regeneration ... インクリメンタル静的再生成
  - SSGと同じように事前ビルドされた静的ファイルをレスポンスとして返すが、このデータに有効期限を設定でき、有効期限が切れたあとはバックグラウンドで再度`getStaticProps`を実行してページをレンダリングし、保存されているデータを更新する
  - SSGとSSRの中間のようなレンダリング手法

- `SSG+CSR`の場合、SSGで生成した部分はキャッシュさせて配信しつつ、必要な箇所だけCSRを用いてその場でレンダリングする
  - [DEV Community](https://dev.to/)でも同じ手法が取られている

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
```tsx
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
- locale ... next.config.jsでi18nの設定をした場合に取得できる
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

## Linkコンポーネント
- `next/link`という組み込みコンポーネントがある
- Linkコンポーネントを使ってページ遷移する場合、Client Side Renderingが発生する。必要なデータは非同期で予め取得されている。
- Linkコンポーネントを使う場合、<a>タグをLinkコンポーネントでラップする
```tsx
import Link from 'next/link'
...
  <Link href="/ssg?keyword=next">
    <a>GO TO SSG with keyword "next"</a>
  </Link>
```


```tsx
import Link from 'next/link'
import { useRouter } from 'next/router'
import { useEffect } from 'react'

// 型注釈が無くてもビルドが通るため省略
function LinkSample() {
  const router = useRouter()

  const onSubmit = () => {
    // /ssrへ遷移します
    router.push('/ssr')

    // 文字列の代わりにオブジェクトで指定できます
    // /ssg?keyword=helloへ遷移します
    router.push({
      pathname: '/ssg',
      query: { keyword: 'hello' },
    })
  }

  const onClickReload = () => {
    router.reload()
  }

  const onClickBack = () => {
    router.back()
  }

  useEffect(() => {
    // 遷移開始時のイベントを購読します
    router.events.on('routeChangeStart', (url, { shallow }) => {
      console.log('routeChangeStart', url)
    })

    // 遷移完了時のイベントを購読します
    router.events.on('routeChangeComplete', (url, { shallow }) => {
      console.log('routeChangeComplete', url)
    })
  }, [])

  return (
    <div style={{display: 'grid', gridTemplateColumns: '1fr', gap: '12px'}}>
      <Link href="/ssg">
        <a>Go TO SSG</a>
      </Link>

      {/* クエリパラメータの指定も可能 */}
      <Link href="/ssg?keyword=next">
        <a>GO TO SSG with keyword "next"</a>
      </Link>
      
      {/* オブジェクトの指定も可能 */}
      <Link
        href={{
          pathname: '/ssg',
          query: { keyword: 'hello' },
        }}>
        <a>GO TO SSG with keyword "hello"</a>
      </Link>
      
      <Link href="/ssg">
        {/* aの代わりにbuttonを使うと、onClickが呼ばれたタイミングで遷移します */}
        <button>Jump to SSG page</button>
      </Link>
      <button onClick={onSubmit}>Submit</button>
      <button onClick={onClickReload}>Reload</button>
      <button onClick={onClickBack}>Back</button>

    </div>
  )
}

export default LinkSample
```

## Imageコンポーネント
- imgタグではなく、Imageコンポーネントを使うことで、画像を読み込む際にサーバーサイドで画像の最適化を行う
- 具体的には、ブラウザ情報を元に最適化した画像を提供する。例えばWebP対応ブラウザにはWebP形式の画像を提供したりする
- Imageコンポーネントはimgタグと同様の値を渡すことができるが外部リソースの場合、`width`と`height`は必須。(`layout=fill`を渡すときは例外)
- プロジェクト内で参照できるローカルの画像に対しては、importで静的インポートした画像ファイルをsrcに与えることができ、widthとheightは省略できる
- 初期画面でビューポートに表示されていない画像は描画しない。画像読み込み中は領域が確保されている。
- Imageコンポーネントにはいくつかのパラメータをpropsに渡すことができる
- `layout`のパラメータは以下の通り
  - `intrinsic`: default. ビューポートが画像サイズより小さい時、ビューポートに応じてリサイズした画像を表示
  - `responsive`: ビューポートに応じてリサイズした画像を表示
  - `fixed`: widthとheightに準拠し、ビューポートの大きさによらず同じサイズの画像を表示
  - `fill`: 親要素に合わせた画像を表示
- `placeholder`に`blur`を設定すると、ぼかし画像を設定できる
- `src`に外部リソースの画像を表示する場合、デフォルトでは最適化した画像を表示できないため、`next.config.js`を設定する必要がある
```js
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  images: {
    domains: ['example.com'] //この設定が必要
  }
}

module.exports = nextConfig
```

### Code
```tsx
import { NextPage } from 'next'
import Image from 'next/image'
// 画像ファイルをインポートする
import BibleImage from '../public/images/bible.jpeg'

const ImageSample: NextPage<void> = (props) => {
  return (
    <div>
      <h1>画像表示の比較</h1>
      
      <p>imgタグで表示した場合</p>
      {/* 通常のimgタグを使用して画像を表示 */}
      <img src="/images/bible.jpeg" />

      <p>Imageコンポーネントで表示した場合</p>
      {/* Imageコンポーネントを使用して表示 */}
      {/* パスを指定する代わりに、インポートした画像を指定 */}
      <Image src={BibleImage} />
      <Image
        alt="Bible"
        src={BibleImage}
        layout="intrinsic"
        width={700}
        height={475}
      />


      <p>Imageで表示した場合は事前に描画エリアが確保されます</p>
    </div>
  )
}

export default ImageSample
```

## APIルート
- `pages/api`においたファイルは、APIを定義する
- ファイルパスで、APIのパスが決まる
- ページで使う簡易的なAPIの実装、Proxyとして利用できる
```ts
import type { NextApiRequest, NextApiResponse } from 'next'

type HelloResponse = {
  name: string
}

// /api/helloで呼ばれたときのAPIの挙動を実装する
export default (req: NextApiRequest, res: NextApiResponse<HelloResponse>) => {
  // ステータス200で{"name": "John Doe"}を返す
  res.status(200).json({ name: 'John Doe' })
}
```

- 上記APIは、CSRでアクセスする
```tsx
import {useState, useEffect} from 'react'

function Sayhello(){
    // 内部で状態を持つためuseStateを利用
    const [data, setData] = useState({name: ''})
    // 外部のAPIにリクエストするのは副作用なのでuseEffect内で処理
    useEffect(() =>{
        // pages/api/hello.tsの内容にリクエスト
        fetch('api/hello')
          .then((res) => res.json())
          .then((profile) => {
              setData(profile)
          })
    }, [])

    return <div>hello {data.name}</div>
}

export default Sayhello
```

## 環境変数, Config
- ビルトインで環境変数のための`.env`ファイルを処理できる
- 次の形式のファイルを参照できる
  - `.env`
  - `.env.local`
  - `.env.${環境名}` like `.env.development` or `.env.production`
  - `.env.${環境名}.local`
- 読み込まれた環境変数は、サーバーサイドで実行する処理から参照できる
- クライアントサイドでもアクセスしたい値に関しては、環境変数の名前の頭に`NEXT_PUBLIC_`をつける 
```tsx
import { NextPage, GetStaticProps } from 'next'
import Head from 'next/head'

const EnvSample: NextPage = (props) => {
  // サーバーサイドで描画する時は'test1'と表示され、クライアントサイドで再描画する時はundefinedと表示される
  console.log('process.env.TEST', process.env.TEST)
  // 'test2'と表示される
  console.log('process.env.NEXT_PUBLIC_TEST', process.env.NEXT_PUBLIC_TEST)

  return (
    <div>
      <Head>
        <title>Create Next App</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main>
        {/* サーバーサイド描画時は'test1'と表示され、クライアントサイドで再描画されると何も表示されない */}
        <p>{process.env.TEST}</p>
        {/* test2が表示される */}
        <p>{process.env.NEXT_PUBLIC_TEST}</p>
      </main>
    </div>
  )
}

// getStaticPropsは常にサーバーサイドで実行されるので、すべての環境変数を参照できる
export const getStaticProps: GetStaticProps = async (context) => {
  // 'test1'が表示される
  console.log('process.env.TEST', process.env.TEST)
  // 'test2'が表示される
  console.log('process.env.NEXT_PUBLIC_TEST', process.env.NEXT_PUBLIC_TEST)

  return {
    props: {

    },
  }
}

export default EnvSample
```

## Next.js の「next start・next dev」挙動差分一覧
- [Next.js の「next start・next dev」挙動差分一覧](https://zenn.dev/takepepe/scraps/321ce98dd8a81a)
