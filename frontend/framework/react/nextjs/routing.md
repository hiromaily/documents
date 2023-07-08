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

### [Defining Routes](https://nextjs.org/docs/app/building-your-application/routing/defining-routes)

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
