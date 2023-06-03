# useSyncExternalStore

外部の store を subscribe するための React Hook

## References [Docs](https://react.dev/reference/react/useSyncExternalStore)

## 用途
- React の外部で状態を管理するライブラリを開発するとき
- ブラウザーのイベント API(ブラウザのサイズが変化したなど) をサブスクライブするとき

## How to use
- コンポーネントのトップレベルで、 useSyncExternalStore を呼び出す

## 引数
- subscribe function
  - ストアが変更されるたびに呼び出されるコールバックを登録するための関数
- getSnapshot function
  - ストアの現在の値を返す
- getServerSnapshot function (Option)
  - サーバーレンダリング時にスナップショットを返すための関数
