# Svelete

Privary features are

- Svelte is a compiler
- Write less code
  - Readability is important
- No virtual DOM

## Requirements

- Node: 16.7+

## References

- [svelte official](https://svelte.dev/)
- [svelte official (jp)](https://svelte.jp/)
- [github](https://github.com/sveltejs/svelte)
- [tutorial](https://svelte.dev/tutorial/basics)
- [tutorial (jp)](https://svelte.jp/tutorial/basics)

## Development reference

- [Vitejs](https://vitejs.dev/)
- [Vitejs plugin](https://github.com/sveltejs/vite-plugin-svelte/)
- [vscode plugin](https://marketplace.visualstudio.com/items?itemName=svelte.svelte-vscode)
- [Svelte for new developers](https://svelte.jp/blog/svelte-for-new-developers)

### SvelteKit

- [SvelteKit](https://kit.svelte.dev/)
- [SvelteKit (jp)](https://kit.svelte.jp/)
- [Git Docs](https://github.com/sveltejs/kit/tree/master/documentation/docs)
- [Docs](https://kit.svelte.dev/docs/introduction)
- [Docs (jp)](https://kit.svelte.jp/docs/introduction)
- [faq](https://kit.svelte.dev/faq)

### Others

- [Svelte + TypeScript のベストプラクティスを考える](https://zenn.dev/mizchi/scraps/a5644f129032aa)
- [Svelte + TypeScript で軽量の JavaScript アプリを！](https://qiita.com/tronicboy/items/923fef6122ed3cf7031f)

## Setup

```sh
# Use SvelteKit for building tool
npm init svelte my-app
cd my-app
npm install
npm run dev

# Use Vitejs for building tool
npm init vite my-app2 -- --template svelte
cd my-app2
```

## Configuration

### svelte.config.js

- [Svelete Configuration](https://kit.svelte.dev/docs/configuration)
- [Svelete Configuration (jp)](https://kit.svelte.jp/docs/configuration)

## Deploy

- [Adapters](https://kit.svelte.dev/docs/adapters)
- [Adapters(jp)](https://kit.svelte.jp/docs/adapters)

### Procedure

```sh
tsc --noEmit
npx vite build
# target dirs are
# - static/
# - build/
```

- github pages に、deploy する場合、svelte で出力したディレクトリ`_app`内のファイルが 400 エラーになり、`app`にリネームすることで対応した。
- svelte.config.js の変更

```ts
const config = {
 kit: {
    ...
  appDir: 'app',
    ...
 }
};
```
