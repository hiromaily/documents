# Recoil

- Reduxの問題点
  - Reduxは状態管理を行なっているストアがひとつであるがゆえに、アプリケーション上のデータを常に上書きする。たとえばストアの状態を空オブジェクトのみで更新してしまうと、アプリケーション上のデータはすべて消えてしまう
- Context APIの制約
  - Context APIで管理されているReactコンポーネントの状態を変更するためには祖先コンポーネントまで辿ってツリーを更新しなくてはいけない
- Recoilとは？
  - Context APIが抱えるこれらの制約・問題を解決するためにFacebookによって提唱された実験的な状態管理ライブラリ
  - 「Atom」「Selector」と呼ばれる単位を使用してアプリケーションデータを管理し、各Atomには一意のキーとそれが管理するデータの一部が含まれている
  - 各Selectorは複数のAtomにもとづく派生状態の一部で、Atom・他のSelectorを受け取る純粋な関数として定義する
  - これらの単位をHooks APIで操作しながら状態管理を行うのがRecoil

recoilより、[Jotai](./jotai.md)のほうがよさそう

## References

- [recoil](https://recoiljs.org/)
- [github](https://github.com/facebookexperimental/Recoil)
- [Docs](https://recoiljs.org/docs/introduction/installation)
- [Reactの新しい状態管理ライブラリ「Recoil」とは？ Reduxとの違いを解説](https://ics.media/entry/210224/)

## Atom

- Atomは状態の単位で、Atomが更新されるとコンポーネントは再レンダリングされる
- 同じAtomが複数のコンポーネントで使われるとき、全てのコンポーネントがそのAtomを共有する
- Atom関数を使って定義するが、keyはユニークである必要がある

```ts
const fontSizeState = atom({
  key: 'fontSizeState',
  default: 14,
});
```

- useRecoilState()を使ってアクセスするが、コンポーネント間で状態が共有される

```ts
function FontButton() {
  const [fontSize, setFontSize] = useRecoilState(fontSizeState);
  return (
    <button onClick={() => setFontSize((size) => size + 1)} style={{fontSize}}>
      Click to Enlarge
    </button>
  );
}

// 別コンポーネントで状態が共有されるためボタンをクリックすると
// FontButtonのfontSizeと下記TextのfontSizeは同じになる
function Text() {
  const [fontSize, setFontSize] = useRecoilState(fontSizeState);
  return <p style={{fontSize}}>This text will increase in size too.</p>;
}
```

## Selector

- `Selector`は`Atom`または他の`Selector`を入力として受け取る関数で、同期的または非同期的に状態を変化させる
- 入力として受け取った`Atom`、または入力として受け取った`Selector`が更新されると`Selector`は再計算される
- また、`Selector`が変わったときに再レンダリングされる
- `get`プロパティの引数を使って`Atom`と他の`Selector`にアクセスできる

```ts
// 内部でgetでAtomにアクセスして状態を変化させている
const fontSizeLabelState = selector({
  key: 'fontSizeLabelState',
  get: ({get}) => {
    // fontSizeState Atom
    const fontSize = get(fontSizeState);
    const unit = 'px';

    return `${fontSize}${unit}`;
  },
});
```

- `useRecoilValue()`を使うことで`Selector`から値の読み取りを行う

```ts
function FontButton() {
  const [fontSize, setFontSize] = useRecoilState(fontSizeState);
  const fontSizeLabel = useRecoilValue(fontSizeLabelState);

  return (
    <>
      <div>Current font size: {fontSizeLabel}</div>

      <button onClick={() => setFontSize(fontSize + 1)} style={{fontSize}}>
        Click to Enlarge
      </button>
    </>
  );
}
```
