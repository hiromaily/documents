# Firebase

- BaaS（Backend as a Service）の一つで、モバイルアプリケーションや Web アプリケーションのバックエンド機能を提供するクラウドサービス
- 登録・管理などのバックエンド処理をすべて行うため、開発者はアプリケーションの開発に専念できる
- データベース以外に、SNS 連携や Android・iOS の SDK を備えている
- サーバ周りの構築や運用の負担が軽減されることで、サーバサイドの開発費・開発期間が抑えられる

## References

- [Official](https://firebase.google.com/?hl=ja)
- [Console](https://console.firebase.google.com/?pli=1)

## 機能

- Authentication: ユーザ認証
- Analytics: アプリケーションの利用状況や分析
- Hosting: Web コンテンツの公開
- Messaging: Push 通知
- Firestore Database: リアルタイム NoSQL データベース
- Realtime Database: 保存と同期がリアルタイムにできるデータベース
- Functions: サーバーレスアプリケーション。イベントを受けて関数を実行する
- Storage: ファイルなどの任意データのストレージ
- Machine Learning: テキスト・画像認識などの機械学習
- Remote Config: アプリケーションの実験やカスタマイズなどに、構成パラメーターや`feature flag`を導入する機能

## [Plan](https://firebase.google.com/pricing?authuser=0&hl=en)

- Spark: 無料
- Blaze: 従量課金
  - Functions は、Blaze でしか使えない

## CLI の Install

- [CLI Docs](https://firebase.google.com/docs/cli?hl=ja)

```sh
npm install -g firebase-tools

# login
firebase login

# initialization
cd <your-project-dir>
firebase init
```

### `firebase init`時の項目

- Realtime Database: Configure a security rules file for Realtime Database and (optionally) provision default instance
- Firestore: Configure security rules and indexes files for Firestore
- Functions: Configure a Cloud Functions directory and its files
- Hosting: Configure files for Firebase Hosting and (optionally) set up GitHub Action deploys
  - Hosting サービスを利用する
  - これにより、local 環境とクラウド上の Project を関連付ける
- Hosting: Set up GitHub Action deploys
- Storage: Configure a security rules file for Cloud Storage
- Emulators: Set up local emulators for Firebase products
- Remote Config: Configure a template file for Remote Config
