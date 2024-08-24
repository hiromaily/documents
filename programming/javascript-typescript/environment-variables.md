# Environment Variables

- Node.js 上では、JavaScript のコードから process.env オブジェクトにアクセスすることによって、環境変数を読み取ることができるが、クライアント側つまり、ブラウザで実行中の JavaScript では、`process`という名前空間は定義されていない。
- クライアント側でも利用する場合は、`webpack`などのバンドラーによって値を注入することで読み込むことができる。
- そのため、環境変数にシークレット情報を使うとコード内に埋め込まれてしまう危険性がある。

## 環境変数を取り扱う方法

- `.env`ファイルを使う
  - `.env.development`, `env.production`といったファイルに環境ごとに作る。React で実行したときに、開発環境では、`.env.development`が優先される

## アクセス方法

- コード内では、`process.env.ENV_NAME`でアクセスする

## React

[Adding Custom Environment Variables](https://create-react-app.dev/docs/adding-custom-environment-variables/)

- デフォルトでは、`NODE_ENV`と、`REACT_APP_`で始まるその他の環境変数が定義されている
- 環境変数はビルド時に埋め込まれる
- `Create React App` (つまり開発環境)は静的な HTML/CSS/JS バンドルを生成するため、実行時にこれらを読み込むことはできない
- 実行時にこれらを読み込むには、[Injecting Data from the Server into the Page](https://create-react-app.dev/docs/title-and-meta-tags/#injecting-data-from-the-server-into-the-page)の通り、サーバー上のメモリに HTML をロードし、実行時にプレースホルダを置き換える必要がある。あるいは、変更するたびにサーバー上でアプリを再構築することもできる。
- `REACT_APP_`で始まるカスタム環境変数を作成する必要がある。
- `NODE_ENV`以外の変数は無視される
- 環境変数を変更すると、開発サーバーが実行されている場合は再起動する必要がある
- これらの環境変数は、process.env で定義される

### NODE_ENV の挙動

- `npm start`を実行すると常に`'development'`
- `npm test`を実行すると常に`'test'`
- `npm run build`を実行して production バンドルを作成すると常に`'production'`
- NODE_ENV を手動で上書きすることはできない
- 起動時に一時的に設定することも可能
  - `REACT_APP_NOT_SECRET_CODE=abcdef && npm start`

### `.env`ファイルの種類

- .`env`: デフォルト
- `.env.local`: ローカル・オーバーライド。このファイルは test 以外のすべての環境で読み込まれる
- `.env.development`、`.env.test`、`.env.production`: 環境固有の設定
- `.env.development.local`、`.env.test.local`、`.env.production.local`: 環境固有の設定をローカルでオーバーライドする

## Next.js

- [Next.js 環境変数](https://nextjs.org/docs/pages/building-your-application/configuring/environment-variables)
- [Next.js: 環境変数(ja)](https://nextjs-ja-translation-docs.vercel.app/docs/basic-features/environment-variables)

- `.env.local` を使用して環境変数をロードする
- `NEXT_PUBLIC_` prefix を用いてブラウザに環境変数を公開する
- Node.js 環境では、通常の名前で環境変数を使うことができる

```
DB_HOST=localhost
DB_USER=myuser
DB_PASS=password
```

```js
export async function getStaticProps() {.
  const  db  = await myDB.connect({)
    host: process.env.DB_HOST、
    username: process.env.DB_USER、
    password: process.env.DB_PASS、
 })
  // ...
}
```

- ブラウザから環境変数の値にアクセスできるようにするために、Next.js はビルド時に、クライアントに配信される js バンドルに値を挿入し、process.env.VARIABLE への参照をすべてハードコードされた値に置き換えることができる
- これを行うには、変数の前に`NEXT_PUBLIC_`を付ける

```
NEXT_PUBLIC_ANALYTICS_ID=abcdefghijk
```

- ビルド後、環境変数を変更しても App は検知しない
- ただし、注意すべき点として、`動的検索`はインライン化されない

```js
// 変数を使用しているため、インライン化されません。
const varName = "NEXT_PUBLIC_ANALYTICS_ID";
setupAnalyticsService(process.env[varName]);

// 変数を使用しているため、インライン化されません。
const env = process.env;
setupAnalyticsService(env.NEXT_PUBLIC_ANALYTICS_ID);
```

- 環境変数`NODE_ENV`が割り当てられていない場合、Next.js は`dev`コマンドの実行時に自動的に`development`を割り当てる

### Test 環境について

- 開発環境と本番環境とは別に、3 番目のオプションとして`test`がある
- 開発環境や本番環境にデフォルトを設定できるのと同じように、テスト環境用の`.env.test`ファイルでも同じことができる
- Next.js は、テスト環境で`.env.development`や `.env.production`から環境変数を読み込まない
- `NODE_ENV`が`test` に設定されている場合は、テストのデフォルト値が読み込まれるが、これはテストツールが対応してくれるので、通常は手動で設定する必要はない
- `.env.local`も Test 環境では読み込まれない

### 環境変数のロード順序

1. process.env
2. .env.$(NODE_ENV).local
3. .env.local (test 環境は除く)
4. .env.$(NODE_ENV)
5. .env

## [Tree shaking](https://developer.mozilla.org/ja/docs/Glossary/Tree_shaking)

- 実行されないコードを削除すること
- モダンな JavaScript アプリケーションの開発では、webpack や Rollup のようなモジュールバンドラーが複数の JavaScript ファイルを 1 つにまとめるが、この際に tree shaking が行われる
- Tree shaking は、コードの構造を整理してファイルサイズを小さくできる
- つまり、以下のようなコードがあった場合、`production`環境用に Build したコードは、`// import module A` のみしか含まれない。

```ts
if (process.env.NODE_ENV === 'production') {
  // import module A
else {
  // import module B
}
```
