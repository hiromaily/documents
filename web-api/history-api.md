# History API

History APIは、Webブラウザの履歴スタックを操作するためのAPIで、シングルページアプリケーション（SPA）や履歴管理が重要なWebアプリケーションで特によく使用される。このAPIを利用することで、ページ遷移の履歴をプログラム的に追加、置換、移動することが可能になる。また、ユーザーがブラウザのバック/フォワードボタンを使用する際にも適切に対応することができるため、より自然なユーザーインターフェースを実現できる。

## 主な機能

1. **履歴の操作**:
   - `history.pushState()`: 履歴スタックに新しいエントリを追加する。
   - `history.replaceState()`: 現在の履歴エントリを新しいデータで置換する。
   - `history.back()`: 履歴を一つ前に戻す（ブラウザのバックボタンと同等）。
   - `history.forward()`: 履歴を一つ進める（ブラウザのフォワードボタンと同等）。
   - `history.go()`: 相対的に履歴を移動する。

2. **状態管理**:
   - 任意の状態オブジェクトを保存し、このオブジェクトを使用して履歴エントリを復元できるため、状態保持が可能。

3. **イベントリスニング**:
   - `popstate` イベントをListenすることで、ユーザーがブラウザのバック/フォワードボタンを押した際に適切な処理を実行できる。

## 基本的な使用方法

1. **pushStateとreplaceStateの使用**:

   ```js
   // 新しい履歴エントリを追加
   const state = { page: 1 };
   const title = ''; // 現在は無視される
   const url = 'page1.html';
   history.pushState(state, title, url);

   // 現在の履歴エントリを置換
   const newState = { page: 2 };
   history.replaceState(newState, title, 'page2.html');
   ```

2. **イベントリスニング**:

   ```js
   window.addEventListener('popstate', (event) => {
       console.log('Location: ' + document.location + ', State: ' + JSON.stringify(event.state));
   });
   ```

3. **履歴の移動**:

   ```js
   // 一つ前の履歴エントリに移動
   history.back();
   
   // 一つ次の履歴エントリに移動
   history.forward();
   
   // 2つ前の履歴エントリに移動
   history.go(-2);
   
   // 現在の履歴エントリの状態を取得
   const currentState = history.state;
   ```

## コンポーネントの説明

1. **history.pushState(state, title, url)**:
   - `state`: 保存する任意のJavaScriptオブジェクト。
   - `title`: 新しい履歴エントリのタイトル（現在はほとんどのブラウザで無視される）。
   - `url`: 新しい履歴エントリが指すURL。

2. **history.replaceState(state, title, url)**:
   - `state`, `title`, `url`は`pushState`と同様。

3. **popstateイベント**:
   - バック/フォワードボタンが押されたときや、`history.go()`が呼ばれたときに発生する。
   - イベントオブジェクトには、`state`プロパティが含まれ、`pushState`や`replaceState`で保存した状態オブジェクトが格納される。
