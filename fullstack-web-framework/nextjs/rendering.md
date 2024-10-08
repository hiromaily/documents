# Rendering

[Rendering](https://nextjs.org/docs/app/building-your-application/rendering)

## レンダリングの種類

- Static Rendering (Default)
  - コンポーネントはビルド時にサーバー上でレンダリングされる。結果はキャッシュされ、以降のリクエストで再利用される
  - CDN でこのデータを配信可能
- Dynamic Rendering
  - コンポーネントはリクエスト時にサーバー上でレンダリングされる

## Data fetching

- Static Data Fetching (Default)
  - `cache`オプションを設定していない fetch リクエストは、強制`cache`オプションを使用することになる
  - ルート内の fetch リクエストが`revalidate`オプションを使用している場合、ルートは revalidation 中に静的に再レンダリングされる
- Dynamic Data Fetching
  - Static Rendering 中に、Dynamic Function または Daynamic `fetch()` リクエスト（キャッシュなし）が検出されると、Next.js はリクエスト時にルート全体を Dynamic Rendering に切り替える。
  - キャッシュされたデータリクエストは、Dynamic Rendering 中でも再利用できる
  - cache option を`no-store`に設定するか、`revalidate`を`0`に設定した状態で`fetch()`リクエストする場合、Dynamic Data Fetching になる
  - これは、[Route Segment Config](https://nextjs.org/docs/app/api-reference/file-conventions/route-segment-config)によって設定することも可能
  - 詳細は、[Data Fetching](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching)

![rendering pattern](https://github.com/hiromaily/documents/raw/main/images/nextjs-rendering-pattern.png 'rendering pattern')

## Dynamic Functions

Dynamic Function は、User の Cookie、現在の Request Header、URL の検索パラメータなど、リクエスト時にしかわからない情報に依存する。

- Server Components で`cookies()`や`headers()`を使用すると、リクエスト時にルート全体が Dynamic Rendering になる。
- Client Components で `useSearchParams()` を使用すると、Dynamic Rendering をスキップし、代わりにクライアント上で最も近い parent Suspense 境界まですべての Client Components をレンダリングする。
  - `useSearchParams()`を使用する Client Components を`<Suspense/>`境界で囲むことを推奨する。こうすることで、それより先の Client Components を静的にレンダリングすることができる。
- `searchParams` Pages prop を使用すると、リクエスト時にページが Daynamic Rendering される
- データフェッチがキャッシュされるかどうかに関係なく、Dynamic function が常にルートを Dynamic Rendering にする

## レンダリングの種類 (この情報は古いので削除予定)

- SSG: Static Site Generation ... 静的サイト生成
  - ビルド時に`getStaticProps`という関数が呼ばれ、API でデータを取得して、レンダリングした結果を静的ファイルとして生成する
  - ページにアクセスがあった場合、生成された静的ファイルをレスポンスとして返す
  - リアルタイム性が求められるコンテンツには適さない
  - パフォーマンスに優れているため、SSG が推奨されている
- CSR: Client Side Rendering
  - ブラウザで初期描画後、非同期で取得したデータをもとにレンダリングを行う
  - SEO にあまり有効ではない
  - SSG, SSR, ISR と組み合わせて利用される
  - 初期描画がそこまで重要ではなく、リアルタイム性が重要なページに適している
- SSR: Server Side Rendering
  - ページへのアクセスがある度にサーバーで`getServerSideProps`関数を呼出し、サーバー側でレンダリングした結果をクライアントに返す
  - そのため、動的データであっても、SEO に有効
  - 低レイテンシーに陥る可能性がある
  - デメリットは、ユーザーごとに HTML を生成させることになり、キャッシュがきかないため、UX を損なう
- ISR: Incremental Static Regeneration ... インクリメンタル静的再生成

  - SSG と同じように事前ビルドされた静的ファイルをレスポンスとして返すが、このデータに有効期限を設定でき、有効期限が切れたあとはバックグラウンドで再度`getStaticProps`を実行してページをレンダリングし、保存されているデータを更新する
  - SSG と SSR の中間のようなレンダリング手法

- `SSG+CSR`の場合、SSG で生成した部分はキャッシュさせて配信しつつ、必要な箇所だけ CSR を用いてその場でレンダリングする
  - [DEV Community](https://dev.to/)でも同じ手法が取られている

## どのように Rendering 手法を切り替えるか？(この情報は古いので削除予定)

- ファイル内部でコンポーネントの他に実装する関数や関数の返す値によって、レンダリング手法が切り替わる
- 主な要素はデータ取得の関数
  - SSG: getStaticProps ... ビルド時にデータを取得
  - SSR: getServerSideProps ... ユーザーのリクエスト時
  - ISR: getStaticProps(revalidate を返す)
- ビルド時の結果から確認できる
