# APIルート

- `pages/api`においたファイルは、APIを定義する
- ファイルパスで、APIのパスが決まる
- ページで使う簡易的なAPIの実装、Proxyとして利用できる

```ts
import type { NextApiRequest, NextApiResponse } from 'next'

type HelloResponse = {
  name: string
}

// /api/helloで呼ばれたときのAPIの挙動を実装する
export default (req: NextApiRequest, res: NextApiResponse<HelloResponse>) => {
  // ステータス200で{"name": "John Doe"}を返す
  res.status(200).json({ name: 'John Doe' })
}
```

- 上記APIは、CSRでアクセスする
```tsx
import {useState, useEffect} from 'react'

function Sayhello(){
    // 内部で状態を持つためuseStateを利用
    const [data, setData] = useState({name: ''})
    // 外部のAPIにリクエストするのは副作用なのでuseEffect内で処理
    useEffect(() =>{
        // pages/api/hello.tsの内容にリクエスト
        fetch('api/hello')
          .then((res) => res.json())
          .then((profile) => {
              setData(profile)
          })
    }, [])

    return <div>hello {data.name}</div>
}

export default Sayhello
```
