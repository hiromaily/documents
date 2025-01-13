# Webアプリケーションの手法

1. **CSR (Client-Side Rendering)**
   - クライアントサイドでDOMを更新する手法

2. **SSR (Server-Side Rendering)**
   - リクエスト時にサーバーサイドでHTMLを生成する手法

3. **SPA (Single-Page Application)**
   - ソフトナビゲーションを行うアプリケーション全般(SSR/SSG と共存する概念)

4. **MPA**
   - ハードナビゲーションを行い、サーバーで生成したHTMLを表示するアプリケーション

5. **PPR (Partial Prerendering)**
   - 同一のルート(ページ)内でSSR/SSGのようにレンダリングするコンポーネントを両立する手法

## 用語

- ソフトナビゲーション
  - ブラウザのJavaScriptを利用して、URL、Historyを直接書き換えながら、DOMを操作して画面を更新するナビゲーション（画面遷移）
- ハードナビゲーション
  - ブラウザの標準的なナビゲーション方法を指す

## References

- [【レンダリング大全】CSR, SSR, SPA, MPA, PPRの意味、そもそもレンダリングとは【2025年始】](https://zenn.dev/txxm/articles/f04b21949ddab3)
