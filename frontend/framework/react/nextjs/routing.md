# Routing

- [Routing Fundamentals](https://nextjs.org/docs/app/building-your-application/routing)
- [Working with the app directory in Next.js 13](https://blog.logrocket.com/next-js-13-app-directory/)
- Next.js は`file-system routing`を採用している

## app ディレクトリと pages ディレクトリの違い

## [App Router](https://nextjs.org/docs/app) recommended

[Routing](https://nextjs.org/docs/app/building-your-application/routing)

![component-tree](../../../../images/nextjs-component-tree.png 'component-tree')

- Version:13 で、Next.js は`React Server Components`をベースにした新しい`App Router`を導入し、共有レイアウト、ネストされたルーティング、loding states、エラー処理などをサポートした
- App Router は`app`ディレクトリで動作する
- `app`ディレクトリは`pages`ディレクトリと並んで動作する
- App Router は Page Router よりも優先される
- ディレクトリをまたがる Routing は同じ URL パスに解決されるべきではなく、競合を防ぐためにビルド時にエラーが発生する
- 例えば、[app]/[profile]/[settings] page.jsx とあった場合、`http://your-host/profile/settings`でアクセスできる

### [File Conventions](https://nextjs.org/docs/app/building-your-application/routing#file-conventions)

ネストされた Route に対して、以下のファイルが有効となる。これらのファイルの拡張子は、`.js`, `.jsx`, `.tsx`となり得る。  
また、`page.js`や`route.js`が返す Contents のみが公開アドレスになる

- layout
  - Shared UI for a segment and its children
- page
  - Unique UI of a route and make routes publicly accessible
- loading
  - Loading UI for a segment and its children
- not-found
  - Not found UI for a segment and its children
- error
  - Error UI for a segment and its children
- global-error
  - Global Error UI
- route
  - Server-side API endpoint
- template
  - Specialized re-rendered Layout UI
- default
  - Fallback UI for Parallel Routes

### Components の階層

- layout.js
- template.js
- error.js (React error boundary)
- loading.js (React suspense boundary)
- not-found.js (React error boundary)
- page.js or nested layout.js

![component-hierarchy](../../../../images/nextjs-file-conventions-component-hierarchy.png 'component-hierarchy')

- 入れ子になった Route では、セグメントのコンポーネントは、親セグメントのコンポーネントの中に入れ子になる

![nested-component-hierarchy](../../../../images/nextjs-nested-file-conventions-component-hierarchy.png 'nexted-component-hierarchy')

### Client-side Navigation による Server 中心の Routing

ユーザーが新しい Route に移動しても、ブラウザはページをリロードしない。代わりに URL が更新され、Next.js は変更されたセグメントだけをレンダリングする

### 部分レンダリング

- 同一階層内の移動 (`/dashboard/settings`と`/dashboard/analytics`など)を移動する場合、Next.js は変更された Route 内のレイアウトとページのみを fetch してレンダリングする。サブツリーのセグメントより上のものを再フェッチしたり再レンダリングしたりしない。

### 高度なルーティングパターン

#### パラレル Route

同時に 2 つ以上のページを同じビューに表示し、独立してナビゲートできるようにする。独自のサブナビゲーションを持つ分割ビューに使用できる。

#### Route のインターセプト

Route をインターセプトして、別の Route のコンテキストに表示することができる。現在のページのコンテキストを維持することが重要な場合に使える。例えば、あるタスクを編集中にすべてのタスクを表示したり、フィードの写真を拡大したりすることができる

### [Defining Routes](https://nextjs.org/docs/app/building-your-application/routing/defining-routes)

#### Route の作成

- ファイルシステムベースの Router を使用し、フォルダーを使用して Route を定義する
- 各フォルダは、URL セグメントにマップされる Route セグメントを表す
- 特別な`page.js`ファイルを使用して、Route セグメントを一般公開する

### [Pages and Layouts](https://nextjs.org/docs/app/building-your-application/routing/pages-and-layouts)

### [Linking and Navigating](https://nextjs.org/docs/app/building-your-application/routing/linking-and-navigating)

### [Route Groups](https://nextjs.org/docs/app/building-your-application/routing/route-groups)

### [Dynamic Routes](https://nextjs.org/docs/app/building-your-application/routing/dynamic-routes)

### [Loading UI and Streaming](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming)

### [Error Handling](https://nextjs.org/docs/app/building-your-application/routing/error-handling)

### [Parallel Routes](https://nextjs.org/docs/app/building-your-application/routing/parallel-routes)

### [Intercepting Routes](https://nextjs.org/docs/app/building-your-application/routing/intercepting-routes)

### [Route Handlers](https://nextjs.org/docs/app/building-your-application/routing/router-handlers)

### [Middleware](https://nextjs.org/docs/app/building-your-application/routing/middleware)

### [Project Organization and File Colocation](https://nextjs.org/docs/app/building-your-application/routing/colocation)

### [Internationalization](https://nextjs.org/docs/app/building-your-application/routing/internationalization)

## [Pages Router](https://nextjs.org/docs/pages)

[Routing](https://nextjs.org/docs/pages/building-your-application/routing)
