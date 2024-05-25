# Authentication

- Web アプリのログインを実現する機能
- パスワード認証、Google/Facebook/Twitter/Github/Microsoft といった SNS アカウントとの連携も可能
- ショートメッセージ(SMS)や電話番号、email を使った 2 段階認証もサポート

## Authentication の有効化

- firebase ダッシュボードから Authentication を選択し、設定が必要
- ここから手動でユーザーを登録することもできる

## 機能

- `createUserWithEmailAndPassword()`によって新しいユーザーを登録することが可能
- `signInWithEmailAndPassword()`によって既存ユーザーのログインが可能
- `onAuthStateChanged()`によって、ログイン/ログアウトの状態変化をコールバックで検知可能
- または、`getAuth()`で戻り値の`currentUser`プロパティを見て、ログインしていない場合、null となる
