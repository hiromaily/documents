# Github Pages

## Deploy方法

Svelteを使ったアプリケーションの例

1. [gh-pages](https://www.npmjs.com/package/gh-pages)をインストール

   ```sh
   npm install gh-pages --save-dev
   ```

2. videを使ってビルドしている場合: `vide.config`

   ```ts
   // https://vitejs.dev/config/
   export default defineConfig({
     plugins: [svelte(), wasm(), topLevelAwait()],
      base: '/wasm-ar-rust/', // 該当のrepository名を入力
   })
   ```

3. package.jsonに`deploy`を追加

   ```json
     "scripts": {
       "build": "vite build",
       "deploy": "vite build && gh-pages -d dist"
     },
   ```

4. `deploy`を実行

   ```sh
   npm run deploy
   ```

5. `gh-pages`ブランチに該当のリソースがdeployされていることを確認する

6. 該当のrepositoryの`Settings`タブの`Pages`セクションを確認し、deployされたURLを確認
