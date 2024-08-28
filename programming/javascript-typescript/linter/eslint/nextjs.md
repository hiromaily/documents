# ESLint with Next.js

- [next.js/docs/basic-feature/eslint](https://github.com/vercel/next.js/blob/canary/docs/basic-features/eslint.md)

Strict: Includes Next.js' base ESLint configuration along with a stricter Core Web Vitals rule-set. This is the recommended configuration for developers setting up ESLint for the first time.

```json
{
  "extends": "next/core-web-vitals"
}
```

- [next.js packages/eslint-plugin-next 内 該当 Code](https://github.com/vercel/next.js/blob/22ea7d99095cee37b327c5c674a78d893b95d38c/packages/eslint-plugin-next/src/index.ts#L52)

```ts
  'core-web-vitals': {
    plugins: ['@next/next'],
    extends: ['plugin:@next/next/recommended'],
    rules: {
      '@next/next/no-html-link-for-pages': 'error',
      '@next/next/no-sync-scripts': 'error',
    },
  },
```

## References

- [Next.js のプロジェクトを開発しやすいようにする lint と formatter などの設定](https://zenn.dev/brachio_takumi/articles/a8fecd8b1b2742)
- [【2022 年】Next.js + TypeScript + ESLint + Prettier の構成でサクッと環境構築する](https://zenn.dev/hungry_goat/articles/b7ea123eeaaa44)
