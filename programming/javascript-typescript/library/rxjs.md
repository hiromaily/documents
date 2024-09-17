# RxJS

RxJS（Reactive Extensions for JavaScript）は、リアクティブプログラミングを支援するためのライブラリ。具体的には、Observables（オブザーバブル）というデータ構造を中心に、非同期データストリームを扱うための強力なツールセットを提供する。非同期操作やイベントベースのプログラミングを簡素化し、コードの可読性と保守性を向上させるためによく使われる。

RxJSを使うことで、コードの可読性と柔軟性が大きく向上し、複雑な非同期操作を直感的に扱えるようになる。

## 主な特徴

1. **Observables（オブザーバブル）**:
   - オブザーバブルは、ゼロ個以上の値を、同期または非同期で送り出すデータストリームを表現する。
   - 例えば、HTTPリクエストの結果、ユーザーの入力イベント、タイマイベントなどを対象とする。

2. **Operators（オペレーター）**:
   - オペレーターは、オブザーバブルを変換、フィルタリング、結合、その他の操作を行うための関数。
   - `map`, `filter`, `merge`, `concat`, `switchMap` などの多くのオペレーターがある。

3. **Subscription（サブスクリプション）**:
   - サブスクリプションは、オブザーバブルからデータを受け取り始めるための方法。
   - オブザーバブルがデータをエミットし続ける間、サブスクリプションはいくつかのコールバック（next, error, complete）を通じてデータを処理する。

4. **Subject（サブジェクト）**:
   - サブジェクトは、オブザーバブルとObserver（オブザーバー）の両方の側面を持つ特別な型。
   - 複数のオブザーバーがサブジェクトにサブスクライブし、全員が同じデータを受け取ることができる。

## 基本的な使い方

```js
import { of } from 'rxjs';
import { map, filter } from 'rxjs/operators';

// オブザーバブルの作成
const observable = of(1, 2, 3, 4, 5);

// オペレーターを使用してオブザーバブルを変換
const modifiedObservable = observable.pipe(
  filter(value => value % 2 === 0),
  map(value => value * 2)
);

// サブスクリプションしてデータを受け取る
modifiedObservable.subscribe({
  next: value => console.log(value),
  error: err => console.error('Something went wrong: ', err),
  complete: () => console.log('Complete')
});
```

### 主な用途

- UIフレームワークとの連携: AngularではHTTPリクエストやフォームのイベント処理にRxJSが多用されます。
- 非同期プログラミング: Promiseの代替として、複雑な非同期操作のチェーンを簡単に扱うことができます。
- リアルタイムデータ: WebSocketや他のリアルタイムデータストリーム処理。

## References

- [Official](https://rxjs.dev/)
- [github](https://github.com/ReactiveX/rxjs)
