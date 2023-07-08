# Next.js

The React Framework for Production

- [Next.js](https://nextjs.org/)
- [Docs](https://nextjs.org/docs/getting-started)
- [Docs (ja)](https://nextjs-ja-translation-docs.vercel.app/docs/getting-started)

## System Requirements

- Node.js 16.8 or later

## Building Application

- [Routing](./routing.md)
- [Rendering](./rendering.md)
- [Data Fetching](./data-fetching.md)
- [Styling](https://nextjs.org/docs/pages/building-your-application/styling)
- [Optimizing](./optimizations.md)
- [Configuring](https://nextjs.org/docs/pages/building-your-application/configuring)
- [Deploying](https://nextjs.org/docs/pages/building-your-application/deploying)
- [Upgrading](https://nextjs.org/docs/pages/building-your-application/upgrading)

## Functionality / 機能

### Image Component and Image Optimization

- [Docs](https://nextjs.org/docs/basic-features/image-optimization)

- Next.js Image コンポーネント next/image は、HTML の <img> 要素を拡張し、モダンウェブ用に進化させたもの
- このコンポーネントには、優れた`Core Web Vitals`を実現するための、さまざまなパフォーマンスの最適化が組み込まれている

### Internationalized Routing 国際化ルーティング

- [Docs](https://nextjs.org/docs/advanced-features/i18n-routing)

- Next.js は`v10.0.0`から国際化ルーティングをビルトインでサポートしている
- locale のリスト、デフォルト locale、ドメイン固有 locale を指定すると、Next.js が自動的にルーティングを処理する
- `i18n`ルーティングのサポートは、routes と locale の解析を効率化することで、`react-intl`, `react-i18next`, `lingui`, `rosetta`, `next-intl` などの既存の`i18n`ライブラリソリューションを補完することが現在の目的。

### Real Data. Real Performance

- [Analytics](https://nextjs.org/analytics)

### Zero Config

- [Docs](https://nextjs.org/docs/getting-started)

- 自動コンパイルとバンドル。最初からプロダクション用に最適化されている
- これにより、webpack 等の設定の必要がない

### Hybrid: SSG and SSR

- [Docs](https://nextjs.org/docs/basic-features/data-fetching/overview)

- Next.js の Data fetching では、アプリケーションのユースケースに応じて、さまざまな方法でコンテンツをレンダリングすることができる。
- `Server-side Rendering`や`Static Generation`よる pre-rendering
- `Incremental Static Generation`による実行時のコンテンツの更新や生成など

### Incremental Static Regeneration

- [Docs](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration)

- Next.js では、サイトを構築した後に静的ページを作成したり更新したりすることができる。
- `Incremental Static Regeneration` (ISR) を利用すると、サイト全体を再構築することなく、ページ単位で静的生成を行うことができる
- また、静的ページの利点を維持しながら、数百万ページまで拡張することができる。

### Fast Refresh

- [Docs](https://nextjs.org/docs/basic-features/fast-refresh)

- React コンポーネントに対する編集を即座にフィードバックする Next.js の機能
- 9.4 以降のすべての Next.js アプリケーションで、デフォルトで有効になっている
- コンポーネントの状態を失うことなく、ほとんどの編集が 1 秒以内に表示されるようになる

### File-system Routing

- [Docs](https://nextjs.org/docs/routing/introduction)

- `Pages`という概念をベースにしたファイルシステム・ルータ
- `pages`ディレクトリにファイルが追加されると、自動的にそのファイルがルートとして利用できるようになる
- `pages`ディレクトリの中にあるファイルは、もっとも一般的なパターンを定義するために利用することができる

### API Routes

- [Docs](https://nextjs.org/docs/api-routes/introduction)

- API routes は、Next.js で API を構築するためのソリューション
- `pages/api`フォルダ内のファイルは、`/api/*`にマップされ、ページの代わりに`APIエンドポイント`として扱われる
- これらはサーバーサイドのみのバンドルであり、クライアントサイドのバンドルサイズを増やすことはない
- 例えば、以下の API ルート `pages/api/user.js` は、ステータスコード 200 の json レスポンスを返す

```
export default function handler(req, res) {
  res.status(200).json({ name: 'John Doe' })
}
```

### Built-In CSS Support

- [Docs](https://nextjs.org/docs/basic-features/built-in-css-support)

- Next.js では、JavaScript ファイルから CSS ファイルをインポートすることができる

### Middleware

- [Docs](https://nextjs.org/docs/advanced-features/middleware)

- Middleware は、リクエストが完了する前にコードを実行し、受信したリクエストに基づいて、レスポンスを変更することができるようにするもの
  - 書き換え、
  - リダイレクト、
  - ヘッダーの追加、
  - クッキーの設定
- キャッシュされたコンテンツの前に実行されるので、静的なファイルやページをパーソナライズすることができる
- ミドルウェアの一般的な例としては、認証、A/B テスト、ローカライズページ、ボット対策などが挙げられる
- ローカライズページについては、まず国際化ルーティングから始め、より高度なユースケースを実現するためにミドルウェアを実装することができる

## References

- [Next.js の「next start・next dev」挙動差分一覧](https://zenn.dev/takepepe/scraps/321ce98dd8a81a)
