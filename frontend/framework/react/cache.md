# Cache

ライブラリの提供する Hooks が Cache 機能を持っていたとしても、If 文で利用する Hook を切り替えることはできず、Pure の Typescript で記述しなくてはいけないケースが存在する。このとき、自分で HTTP Request の機能を実装を行うときに、どのように Cache 機構を実装するかについてまとめる。

## 状況

HTTP requests の Data Caching を React Hook 内で実装する

## useEffect

- 第 1 引数: 実行させたい副作用関数
- 第 2 引数: 副作用関数の実行タイミングを制御する依存データ
  - これにより、React は第 2 引数の依存配列の中身の値を比較して、副作用関数をスキップするかどうか決定する

```ts
useEffect(() => {
  // implementation
}, [依存する変数の配列]);
```

### Sample Code

```jsx
import { useState, useEffect } from "react";

function useDataCache(url) {
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const cachedData = localStorage.getItem(url);

    if (cachedData) {
      setData(JSON.parse(cachedData));
      setIsLoading(false);
    } else {
      fetch(url)
        .then((response) => response.json())
        .then((data) => {
          localStorage.setItem(url, JSON.stringify(data));
          setData(data);
          setIsLoading(false);
        })
        .catch((error) => {
          setError(error);
          setIsLoading(false);
        });
    }
  }, [url]);

  return { data, error, isLoading };
}
```

- この例では、`useDataCache` Hook が URL を入力として受け取り、Cache されたデータ、リクエスト中に発生したエラー、読み込みインジケータを含むオブジェクトを返す。
- Hook は最初に、提供された URL を Key として使用して、Local Storage から Data を取得しようとする。
- Data が Cache で見つかった場合、Data はすぐに返され、isLoading State は `false` に設定される。
- データが Cache に見つからない場合、Hook は fetch 関数を使用して HTTP 要求を実行する。
- リクエストが成功すると、Response Data は Local Storage に保存され、Hook は Data State と isLoading State を `false` に設定する。
- リクエスト中にエラーが発生した場合、エラー State が設定され、isLoading 状態が `false` に設定される。
- useDataCache Hook を使用するには、機能コンポーネントでそれを呼び出し、HTTP Request の URL をパラメーターとして提供する。

```jsx
import React from "react";
import useDataCache from "./useDataCache";

function MyComponent() {
  const { data, error, isLoading } = useDataCache(
    "https://api.example.com/data"
  );

  if (isLoading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>Error: {error.message}</div>;
  }

  return (
    <div>
      {data.map((item) => (
        <div key={item.id}>{item.name}</div>
      ))}
    </div>
  );
}

export default MyComponent;
```
