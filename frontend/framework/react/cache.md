# Cache

ライブラリの提供するHooksがCache機能を持っていたとしても、If文で利用するHookを切り替えることはできず、PureのTypescriptで記述しなくてはいけないケースが存在する。このとき、自分でHTTP Requestの機能を実装を行うときに、どのようにCache機構を実装するかについてまとめる。

## 状況
HTTP requestsのData CachingをReact Hook内で実装する

## useEffect
- 第1引数: 実行させたい副作用関数
- 第2引数: 副作用関数の実行タイミングを制御する依存データ
  - これにより、Reactは第2引数の依存配列の中身の値を比較して、副作用関数をスキップするかどうか決定する
```ts
useEffect(() => {
  // implementation
  
},[依存する変数の配列])
```

### Sample Code
```jsx
import { useState, useEffect } from 'react';

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
        .then(response => response.json())
        .then(data => {
          localStorage.setItem(url, JSON.stringify(data));
          setData(data);
          setIsLoading(false);
        })
        .catch(error => {
          setError(error);
          setIsLoading(false);
        });
    }
  }, [url]);

  return { data, error, isLoading };
}
```
- この例では、`useDataCache` Hookが URL を入力として受け取り、Cacheされたデータ、リクエスト中に発生したエラー、読み込みインジケータを含むオブジェクトを返す。
- Hookは最初に、提供された URL をKeyとして使用して、Local StorageからDataを取得しようとする。
- DataがCacheで見つかった場合、Dataはすぐに返され、isLoading Stateは `false` に設定される。
- データがCacheに見つからない場合、Hookはfetch関数を使用して HTTP 要求を実行する。
- リクエストが成功すると、Response DataはLocal Storageに保存され、HookはData Stateと isLoading Stateを `false` に設定する。
- リクエスト中にエラーが発生した場合、エラー Stateが設定され、isLoading 状態が `false` に設定される。
- useDataCache Hookを使用するには、機能コンポーネントでそれを呼び出し、HTTP Requestの URL をパラメーターとして提供する。

```jsx
import React from 'react';
import useDataCache from './useDataCache';

function MyComponent() {
  const { data, error, isLoading } = useDataCache('https://api.example.com/data');

  if (isLoading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>Error: {error.message}</div>;
  }

  return (
    <div>
      {data.map(item => (
        <div key={item.id}>{item.name}</div>
      ))}
    </div>
  );
}

export default MyComponent;
```