# front-end

## Trends

- [Front End Development Trends to Watch in 2022](https://www.freecodecamp.org/news/front-end-development-trends/)
  - [Svelte](https://github.com/sveltejs/svelte)
- [7 Frontend Development Trends for 2022 (And Beyond)](https://leanylabs.com/blog/7-frontend-trends/)
  - Popular framework
    1. React
    2. Angular
    3. Vue.js
    4. Sevelte
  - Micro Frontend Architecture
  - Frontend Optimization
    - 92.6% of internet users access the web from mobile devices -> mobile-friendly
    - How to reduce frontend data loading?
      - Bundle and minify HTML, CSS, and JavaScript files
        - webpack, Vite, Rollup
      - Try to avoid bulky libraries that could hinder performance
        - 必要なツールのみを ES6 モジュールからインポートして、`Tree Shaking`を有効にする
        - [Tree Shaking](https://webpack.js.org/guides/tree-shaking/)
      - Reduce the number of server calls
        - CSS sprites
      - Compress files and optimize images
        - JPEGs should be minimized ([MozJPEG](https://github.com/mozilla/mozjpeg), [Guetzli](https://github.com/google/guetzli))
      - Apply lazy loading
      - Enable prefetching 
        - https://developer.mozilla.org/en-US/docs/Web/HTTP/Link_prefetching_FAQ
        - `<link rel="prefetch" href="/images/big.jpeg">`
        - ユーザーがpre-fetchされたドキュメントの 1 つにアクセスすると、ブラウザのキャッシュからすぐに提供される
      - Use a Content Delivery Network (CDN)
        - Netlify, Cloudflare, Google Cloud CDN, Amazon CloudFront, etc
  - Schema Markup (for search rankings)
    - https://developers.google.com/search/docs/advanced/structured-data
  - Headless Architecture (headless CMS)
    - バックエンドのコンテンツ機能 (作成、管理、保存など) をフロントエンドの機能 (プレゼンテーションや配信など) から分離する。
  - Websites Rapidly Improve Accessibility
- [Front-End Development Trends of 2022](https://www.dronahq.com/front-end-development-trends/)
  - [Jamstack](https://jamstack.org/)
    - 最新の高性能SPAを作成するための使いやすいプラットフォームを提供するJSフレームワーク。
    - Jamstack は、re-rendering と decouplingの原則に基づいて動作する。
    - フロントエンド UI とページをデータベース バックエンド アプリから分離する。
    - フロントエンドがバックエンド サーバーから解放されると、グローバルに CDN に簡単に展開できる。
    - 展開前に、フロントエンド全体が高度に最適化された静的ページとアセットに事前に組み込まれている。
    - グローバル フロントエンドは、Javascript と API を使用してバックエンド サービスと通信し、ページを拡張してパーソナライズできるようにする。 
    - [Jamstackって何なの？何がいいの？](https://qiita.com/ozaki25/items/4075d03278d1fb51cc37)
      - templateをビルドしてHTMLを生成する時にAPIからデータを取得して埋め込む
  - [Progressive Web Apps (PWAs)](https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps)
    - Service Worker、マニフェスト、その他の Web プラットフォーム機能をプログレッシブ エンハンスメントと組み合わせて使用し、ネイティブ アプリと同等のエクスペリエンスをユーザーに提供する Web アプリ。
  - Adopting GraphQL
  - [Motion UI](https://github.com/foundation/motion-ui)
  - [Single Page Applications (SPAs)](https://developer.mozilla.org/en-US/docs/Glossary/SPA)
- [Top 10 Front-End Development Trends in 2022](https://www.hackerrank.com/blog/front-end-development-trends-2022/)
  - Front-End Design Trends
    - Accessibility
    - High Performance
    - Mobile-First Design
  - Trending Tools and Technologies
    - GraphQL
    - [Gatsby](https://github.com/gatsbyjs/gatsby)
      - 開発者が非常に高速な Web サイトやアプリを構築するのに役立つ、React baseのフレームワーク
      - 静的サイトジェネレーター, こちらで[確認](https://jamstack.org/generators/)
    - Jamstack
    - Progressive Web Apps
    - [PyScript](https://pyscript.net/)
      - run Python in HTML
    - Server-Side Rendering
    - Single Page Applications


## Framework

But Svelte is growing.

- [Next.js](https://nextjs.org/) is React Framework which can be built by React.js view libraries.
- [Nuxt.js](https://nuxtjs.org/) is Vue Framework which can be built by Vue.js view libraries.
- [Svelte kit](https://kit.svelte.dev/) is Svelte Framework which can be built by Svelte.

## Others

### BFF（Backends For Frontends）
- 各種バックエンドサーバーとフロントエンドの中間に「フロントエンド専用のサーバー」を配置し、リクエストに応じてバックエンドサービスにAPIコールをしたり、バックエンドから取得したデータを加工してフロントエンドに返却する。
- アクセスするデバイス(mobile, web)に合わせて最適化されたレスポンスを作成する