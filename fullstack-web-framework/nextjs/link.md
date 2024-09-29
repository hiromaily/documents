# Linkコンポーネント

- `next/link`という組み込みコンポーネントがある
- Linkコンポーネントを使ってページ遷移する場合、Client Side Renderingが発生する。必要なデータは非同期で予め取得されている。
- Linkコンポーネントを使う場合、`<a>`タグをLinkコンポーネントでラップする

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
    // /ssrへ遷移する
    router.push('/ssr')

    // 文字列の代わりにオブジェクトで指定できる
    // /ssg?keyword=helloへ遷移する
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
    // 遷移開始時のイベントをsubscribeする
    router.events.on('routeChangeStart', (url, { shallow }) => {
      console.log('routeChangeStart', url)
    })

    // 遷移完了時のイベントをsubscribeする
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
        {/* aの代わりにbuttonを使うと、onClickが呼ばれたタイミングで遷移する */}
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
