# Environment Variables

## 環境変数を取り扱う方法
- `.env`ファイルを使う
  - `.env.development`, `env.production`といったファイルに環境ごとに作る。Reactで実行したときに、開発環境では、`.env.development`が優先される
  - [Next.js](https://nextjs.org/docs/pages/building-your-application/configuring/environment-variables)を使う場合、defaultで環境変数を取り扱うことができる。
  - これはバンドルツールなどによってビルド時に置換が内部的に発生することによって、環境変数が使える

## アクセス方法
- コード内では、`process.env.ENV_NAME`でアクセスする