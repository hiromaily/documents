
# Imageコンポーネント

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

## Code

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
