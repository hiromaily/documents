# API ルート

[API Reference](https://nextjs.org/docs/app/api-reference)

- `pages/api`においたファイルは、API を定義する
- ファイルパスで、API のパスが決まる
- ページで使う簡易的な API の実装、Proxy として利用できる

```ts
import type { NextApiRequest, NextApiResponse } from 'next';

type HelloResponse = {
  name: string;
};

// /api/helloで呼ばれたときのAPIの挙動を実装する
export default (req: NextApiRequest, res: NextApiResponse<HelloResponse>) => {
  // ステータス200で{"name": "John Doe"}を返す
  res.status(200).json({ name: 'John Doe' });
};
```

- 上記 API は、CSR でアクセスする

```tsx
import { useState, useEffect } from 'react';

function Sayhello() {
  // 内部で状態を持つためuseStateを利用
  const [data, setData] = useState({ name: '' });
  // 外部のAPIにリクエストするのは副作用なのでuseEffect内で処理
  useEffect(() => {
    // pages/api/hello.tsの内容にリクエスト
    fetch('api/hello')
      .then((res) => res.json())
      .then((profile) => {
        setData(profile);
      });
  }, []);

  return <div>hello {data.name}</div>;
}

export default Sayhello;
```
