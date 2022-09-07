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

### サンプルコード
#### コンテナコンポーネント相当のカスタムフック
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

#### プレゼンテーションコンポーネント
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

### 概要
- 複数のコンポーネントで同じロジックを再利用する方法の 1 つ
- 横断的関心事にHOCを適用する
- HOC は、あるコンポーネントを受け取って新規のコンポーネントを返すような関数
- HOC には、パラメータとして渡されるコンポーネントに適用する何らかのロジックが含まれており、そのロジックを適用した上で、HOC は追加されたロジックとともに要素を返す
- HOC は入力のコンポーネントを改変したり、振る舞いをコピーするのに継承を利用したりせず、元のコンポーネントをコンテナコンポーネント内にラップすることで組み合わせる

### サンプルコード
- このHOCの役割は渡されたコンポーネントに、`style`を適用し、修正されたコンポーネントを返す

```ts
function withStyles(Component) {
  return props => {
    const style = { padding: '0.2rem', margin: '1rem' }
    return <Component style={style} {...props} />
  }
}

const Button = () = <button>Click me!</button>
const Text = () => <p>Hello World!</p>

const StyledButton = withStyles(Button)
const StyedText = withStyles(Text)
```

## Render Props Pattern
- [Render Props Pattern](https://javascriptpatterns.vercel.app/patterns/react-patterns/render-props)
- [Render prop](https://ja.reactjs.org/docs/render-props.html)
- [レンダープロップ パターン](https://zenn.dev/morinokami/books/learning-patterns-1/viewer/render-props-pattern)

### 概要
- props を 通じて JSX 要素をコンポーネントに渡す
- レンダープロップは、JSX の要素を返す関数を値とするコンポーネントの prop
- コンポーネント自身は、レンダープロップ以外のものをレンダリングしない
- コンポーネントは、独自のレンダリングロジックを実装する代わりに、単にレンダープロップを呼び出すだけ

### サンプルコード
- index.ts
```ts
import React from "react";
import { render } from "react-dom";

import "./styles.css";

const Title = (props) => props.render();

render(
  <div className="App">
    <Title
      render={() => (
        <h1>
          <span role="img" aria-label="emoji">
            ✨
          </span>
          I am a render prop!{" "}
          <span role="img" aria-label="emoji">
            ✨
          </span>
        </h1>
      )}
    />
  </div>,
  document.getElementById("root")
);
```

```ts
import React from "react";
import { render } from "react-dom";
import "./styles.css";

const Title = (props) => props.render();

render(
  <div className="App">
    <Title render={() => <h1>✨ First render prop! ✨</h1>} />
    <Title render={() => <h2>🔥 Second render prop! 🔥</h2>} />
    <Title render={() => <h3>🚀 Third render prop! 🚀</h3>} />
  </div>,
  document.getElementById("root")
);
```

```ts
import React from "react";
import { render } from "react-dom";
import "./styles.css";

const Title = (props) => (
  <>
    {props.renderFirstComponent()}
    {props.renderSecondComponent()}
    {props.renderThirdComponent()}
  </>
);

render(
  <div className="App">
    <Title
      renderFirstComponent={() => <h1>✨ First render prop! ✨</h1>}
      renderSecondComponent={() => <h2>🔥 Second render prop! 🔥</h2>}
      renderThirdComponent={() => <h3>🚀 Third render prop! 🚀</h3>}
    />
  </div>,
  document.getElementById("root")
);
```

```tsx
import React from 'react';

// prop
export function Kelvin({ value }) {
  return (
    <div className="temp-card">
      The temperature in Kelvin is: <span className="temp">{value}K</span>
    </div>
  );
}

// prop
export function Fahrenheit({ value }) {
  return (
    <div className="temp-card">
      The temperature in Fahrenheit is:
      <span className="temp">{value}°F</span>
    </div>
  );
}

export default function TemperatureConverter(props) {
  const [value, setValue] = React.useState(0);

  return (
    <div className="card">
      <input
        type="number"
        placeholder="Degrees Celcius"
        onChange={(e) => setValue(parseInt(e.target.value))}
      />
      <Kelvin value={Math.floor(value + 273.15)} />
      <Fahrenheit value={Math.floor((value * 9) / 5 + 32)} />
    </div>
  );
}
```
## Hooks Pattern
- [Hooks Pattern](https://javascriptpatterns.vercel.app/patterns/react-patterns/hooks-pattern)
- [フック パターン](https://zenn.dev/morinokami/books/learning-patterns-1/viewer/hooks-pattern)



## Provider Pattern
- [Provider Pattern](https://javascriptpatterns.vercel.app/patterns/react-patterns/provider-pattern)
- [プロバイダ パターン](https://zenn.dev/morinokami/books/learning-patterns-1/viewer/provider-pattern)

## Compound Pattern
- [Compound Pattern](https://javascriptpatterns.vercel.app/patterns/react-patterns/compound-pattern)
- [複合 パターン](https://zenn.dev/morinokami/books/learning-patterns-1/viewer/compound-pattern)
