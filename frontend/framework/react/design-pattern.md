# React Design Pattern

## Container/Presentational Pattern
- [Container/Presentational Pattern](https://javascriptpatterns.vercel.app/patterns/react-patterns/conpres)
- [コンテナ・プレゼンテーションパターン](https://zenn.dev/morinokami/books/learning-patterns-1/viewer/presentational-container-pattern)

### 概要
- React において関心の分離を実現する方法の一つ
- 多くの場合、コンテナ・プレゼンテーションパターンは React のフックに置き換えることができる
- このパターンは小規模なアプリケーションでは不要に複雑となりがちなので注意
#### 2つのコンポーネント
- プレゼンテーションコンポーネント
  - view相当
  - データがユーザーにどのように表示されるかを管理するコンポーネント
  - プレゼンテーションコンポーネントは、 props を通じてデータを受け取る
- コンテナコンポーネント
  - ロジック相当
  - 何のデータがユーザーに表示されるかを管理するコンポーネント
  - 取得、加工したデータを元に、プレゼンテーションコンポーネントにデータを受け渡す

#### サンプルコード
##### コンテナコンポーネント相当のカスタムフック
```ts
export default function useDogImages() {
  const [dogs, setDogs] = useState([]);

  useEffect(() => {
    fetch("https://dog.ceo/api/breed/labrador/images/random/6")
      .then(res => res.json())
      .then(({ message }) => setDogs(message));
  }, []);

  return dogs;
}
```
- これが以下のように記述可能
```ts
import { useState, useEffect } from "react";

export default function useDogImages() {
  const [dogs, setDogs] = useState([]);

  useEffect(() => {
    async function fetchDogs() {
      const res = await fetch(
        "https://dog.ceo/api/breed/labrador/images/random/6"
      );
      const { message } = await res.json();
      setDogs(message);
    }

    fetchDogs();
  }, []);

  return dogs;
}
```

##### プレゼンテーションコンポーネント
- ここでは、上記で作成したHookを利用してデータを取得している
```ts
import React from "react";
import useDogImages from "./useDogImages";

export default function DogImages() {
  const dogs = useDogImages(); // フックを使ってデータを取得

  return dogs.map((dog, i) => <img src={dog} key={i} alt="Dog" />);
}
```

## Higher-Order Components(HOC)
- [Higher-Order Components](https://javascriptpatterns.vercel.app/patterns/react-patterns/higher-order-component)
- [高階 (Higher-Order) コンポーネント](https://ja.reactjs.org/docs/higher-order-components.html)
- [HOC パターン](https://zenn.dev/morinokami/books/learning-patterns-1/viewer/hoc-pattern)

## Render Props Pattern
- [Render Props Pattern](https://javascriptpatterns.vercel.app/patterns/react-patterns/render-props)
- [Render prop](https://ja.reactjs.org/docs/render-props.html)
- [レンダープロップパターン](https://zenn.dev/morinokami/books/learning-patterns-1/viewer/render-props-pattern)

## Hooks Pattern
- [Hooks Pattern](https://javascriptpatterns.vercel.app/patterns/react-patterns/hooks-pattern)
- [フックパターン](https://zenn.dev/morinokami/books/learning-patterns-1/viewer/hooks-pattern)

## Provider Pattern
- [Provider Pattern](https://javascriptpatterns.vercel.app/patterns/react-patterns/provider-pattern)
- [プロバイダパターン](https://zenn.dev/morinokami/books/learning-patterns-1/viewer/provider-pattern)

## Compound Pattern
- [Compound Pattern](https://javascriptpatterns.vercel.app/patterns/react-patterns/compound-pattern)
- [複合パターン](https://zenn.dev/morinokami/books/learning-patterns-1/viewer/compound-pattern)
