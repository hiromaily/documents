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
        - 必要なツールのみを ES6 モジュールからインポートして、`Tree Shaking`を有効にします
        - [Tree Shaking](https://webpack.js.org/guides/tree-shaking/)
      - Reduce the number of server calls
        - CSS sprites
      - Compress files and optimize images
        - JPEGs should be minimized ([MozJPEG](https://github.com/mozilla/mozjpeg), [Guetzli](https://github.com/google/guetzli))
      - Apply lazy loading
      - Enable prefetching 
        - https://developer.mozilla.org/en-US/docs/Web/HTTP/Link_prefetching_FAQ
        - `<link rel="prefetch" href="/images/big.jpeg">`
        - ユーザーがプリフェッチされたドキュメントの 1 つにアクセスすると、ブラウザのキャッシュからすぐに提供される
      - Use a Content Delivery Network (CDN)
        - Netlify, Cloudflare, Google Cloud CDN, Amazon CloudFront, etc
  - Schema Markup (for search rankings)
    - https://developers.google.com/search/docs/advanced/structured-data
  - Headless Architecture (headless CMS)
    - バックエンドのコンテンツ機能 (作成、管理、保存など) をフロントエンドの機能 (プレゼンテーションや配信など) から分離します。
  - Websites Rapidly Improve Accessibility



## Framework

Vue.js is popular more than React these days. But Svelte is growing.

- [Next.js](https://nextjs.org/) is React Framework which can be built by React.js view libraries.
- [Nuxt.js](https://nuxtjs.org/) is Vue Framework which can be built by Vue.js view libraries.
- [Svelte kit](https://kit.svelte.dev/) is Svelte Framework which can be built by Svelte.

## Others

### BFF（Backends For Frontends）