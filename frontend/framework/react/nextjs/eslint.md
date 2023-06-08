# ESLint

[next.js/docs/basic-feature/eslint](https://github.com/vercel/next.js/blob/canary/docs/basic-features/eslint.md)

Strict: Includes Next.js' base ESLint configuration along with a stricter Core Web Vitals rule-set. This is the recommended configuration for developers setting up ESLint for the first time.

```json
{
  "extends": "next/core-web-vitals"
}
```

- [next.js packages/eslint-plugin-next内 該当Code](https://github.com/vercel/next.js/blob/22ea7d99095cee37b327c5c674a78d893b95d38c/packages/eslint-plugin-next/src/index.ts#L52)

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
