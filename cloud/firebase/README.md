# Firebase

- BaaS（Backend as a Service）の一つで、モバイルアプリケーションやWebアプリケーションのバックエンド機能を提供するクラウドサービス
- 登録・管理などのバックエンド処理をすべて行うため、開発者はアプリケーションの開発に専念できる
- データベース以外に、SNS連携やAndroid・iOSのSDKを備えている
- サーバ周りの構築や運用の負担が軽減されることで、サーバサイドの開発費・開発期間が抑えられる

## References
- [Official](https://firebase.google.com/?hl=ja)
- [Console](https://console.firebase.google.com/?pli=1)

## 機能
- Analytics: アプリケーションの利用状況や分析
- Hosting: Webコンテンツの公開
- Messaging: Push通知
- Firestore Database: リアルタイムNoSQLデータベース
- Realtime Database: 保存と同期がリアルタイムにできるデータベース
- Functions: サーバーレスアプリケーション。イベントを受けて関数を実行する
- Authentication: ユーザ認証
- Storage: ファイルなどの任意データのストレージ
- Machine Learning: テキスト・画像認識などの機械学習
- Remote Config: アプリケーションの実験やカスタマイズなどに、構成パラメーターや`feature flag`を導入する機能

## [API Reference](https://firebase.google.com/docs/reference?hl=ja)
- [Android](https://firebase.google.com/docs/reference/android/packages?hl=ja)
  - Android Java / Android Kotlin
  - ads
  - appindexing (索引付け)
  - measurement
  - firebase
    - firebase.appcheck
    - firebase.auth
    - firebase.crashlytics
    - firebase.database
    - firebase.dynamiclinks
    - firebase.firestore
    - firebase.functions
    - firebase.inappmessaging
    - firebase.inappmessaging.display
    - firebase.iid
    - firebase.installations
    - firebase.messaging
    - firebase.ml.common
    - firebase.ml.interpreter
    - firebase.ml.modeldownloader
    - firebase.ml.naturallanguage
    - firebase.ml.naturallanguage.translate 
    - firebase.ml.vision
    - firebase.perf
    - firebase.remoteconfig
    - firebase.storage
  - Inter-operational packages
- [iOS](https://firebase.google.com/docs/reference/swift/firebasecore/api/reference/Classes?hl=ja)
  - iOS Swift / iOS Objective C
- [Web](https://firebase.google.com/docs/reference/js?hl=ja)
  - ここでいう`Web`とは、一般的なReact/Vue.jsといった`front-end`を指す？？
- [C++](https://firebase.google.com/docs/reference/cpp?hl=ja)
- [Unity](https://firebase.google.com/docs/reference/unity?hl=ja)
- [Admin](https://firebase.google.com/docs/reference/admin?hl=ja)
  - これはFirebaseにアクセスするための各言語のためのSDKとなる？呼び出す環境は、local, webと異なる。
  - Localからのアクセスには、秘密鍵が必要なため、web console画面の設定画面、サービスアカウントから鍵を生成する必要がある
  - LocalからもfirebaseのDBへのアクセスが可能

  - Node.js
    - `npm install firebase-admin --save`
  - Java
  - Python
    - `pip install --upgrade firebase-admin`
  - Go
  - C# (.NET)

## [Plan](https://firebase.google.com/pricing?authuser=0&hl=en)
- Spark: 無料
- Blaze: 従量課金 
  - Functionsは、Blazeでしか使えない

## CLIのInstall
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
  - Hostingサービスを利用する
  - これにより、local環境とクラウド上のProjectを関連付ける
- Hosting: Set up GitHub Action deploys
- Storage: Configure a security rules file for Cloud Storage
- Emulators: Set up local emulators for Firebase products
- Remote Config: Configure a template file for Remote Config

## Hosting Service
- WebリソースのHosting機能で、`public`ディレクトリがdefaultで作成される
- single-page appの作成においても、この項目になる
- githubとの連携も可能
- deployには、`firebase deploy`コマンドを実行する

## Firestore
- Firebase上にあるNoSQLのリアルタイムデータベースで、ドキュメント指向データベースとなる
- そのため、自由な形式のデータをコレクションに保存することができる
- ドキュメント志向データベース補足
  - ドキュメント: RDBでいうレコードで、値はJSON形式となる
    - `doc()関数`でドキュメントの更新ができる
    - `setDoc()関数`によってドキュメントの作成もしくは上書きができるが、作成するドキュメントのIDも指定しなければならない
    - `addDoc()関数`の場合、IDは自動生成される
    - `geDoc()関数`によってデータの読み取りが可能
  - コレクション: RDBでいうテーブル相当で、ドキュメントの束
    - コレクションを特定するために、`collection()関数`によってコレクションへの参照を取得する
- DBへはlocalからでもアクセスが可能
- Firestoneの内容が更新された場合、その更新を検出、反映する仕組みがある
  - `onSnapshot()関数`

## Storage
- 写真や動画、各種データを格納できるサービス
- 任意のファイルやフォルダのことをBlob(Binary Large Object)と呼ぶ
- AmazonS3, GoogleCloudStorageと同じイメージでいい？
- AdminSDKを使って各種言語でアクセスが可能
- ファイルのリスト、ファイルのメタデータにアクセスすることも可能
- アップロードも可能