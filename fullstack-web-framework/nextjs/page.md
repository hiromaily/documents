# Page

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

## SSGによるPage実装

- `getStaticProps()`を定義し、exportする
- `getStaticProps()`の引数に`context`が渡されるが、これはReactの`context`ではない。

### SSG contextのparameter

- params
- locale ... next.config.jsでi18nの設定をした場合に取得できる
- locales
- defaultLocale
- preview
- previewData

### Basic

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

### Blogなど、表示するデータが違うPageにおけるSSG

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

## SSRによるPage実装

- `getServerSideProps()`を定義し、exportする
- `getServerSideProps()`引数の`context`では、`getStaticProps`の`context`で参照できるデータに加え、リクエスト情報などを参照できる

### SSR contextのparameter

- req
- res
- resolvedUrl
- query

### Code

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
