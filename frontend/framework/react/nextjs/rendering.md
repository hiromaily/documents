# Rendering 手法

[Rendering](https://nextjs.org/docs/app/building-your-application/rendering)

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

## どのように Rendering 手法を切り替えるか？

- ファイル内部でコンポーネントの他に実装する関数や関数の返す値によって、レンダリング手法が切り替わる
- 主な要素はデータ取得の関数
  - SSG: getStaticProps ... ビルド時にデータを取得
  - SSR: getServerSideProps ... ユーザーのリクエスト時
  - ISR: getStaticProps(revalidate を返す)
- ビルド時の結果から確認できる
