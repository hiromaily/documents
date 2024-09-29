# Folder

[Next.js Project Structure](https://nextjs.org/docs/getting-started/project-structure): 重要!!

## [Top-level files 構成](https://nextjs.org/docs/getting-started/project-structure)

### Next.js

- next.config.js
  - Configuration file for Next.js
- middleware.ts
  - Next.js request middleware
- instrumentation.ts
  - OpenTelemetry and Instrumentation
- .env
  - Environment variables
- .env.local
  - Local environment variables
- .env.production
  - Production environment variables
- .env.development
  - Development environment variables
- .next-env.d.ts
  - TypeScript declaration file for Next.js

## [Top-level folder 構成](https://nextjs.org/docs/getting-started/project-structure#top-level-folders)

- `app`: App Router
- `pages`: Pages Router
- `public`: Static assets to be served
- `src`: Optional appliation source folder

## [`app` directory](https://nextjs.org/docs/getting-started/installation#the-app-directory)

- App Router が推奨されている
- 使うためには、`app`ディレクトリを用意し、`layout.tsx`と`page.tsx`ファイルを用意する
  - `app/layout.tsx`内に、html コードを含む[root layout](https://nextjs.org/docs/app/building-your-application/routing/pages-and-layouts#root-layout-required)を作成する
  - `app/page.tsx`が初期の中身となる
- `/`にアクセスすることで、これらにアクセスできる

![app direcotry](https://github.com/hiromaily/documents/raw/main/images/nextjs-app-directory.png 'app directory')

### [`app` Routing Conventions](https://nextjs.org/docs/getting-started/project-structure#app-routing-conventions)

#### Routing Files

- layout file
- page file
- loading file
- not-found file
- error file
- global-error file
- route file
- template file
- default

#### Nexted Routes

- folder
- folder / folder

#### Dynamic Routes

- [folder] Dynamic route segment
- [...folder] Catch-all segments
- [[...folder]]

## [`pages` directory](https://nextjs.org/docs/getting-started/installation#the-pages-directory-optional)

- これは`optional`
- App Router の代わりに Page Router を使いたい場合は、それも可能とあるが、両方設定するとどうなるのか？
- `pages`ディレクトリ内に`index.tsx`ファイルを用意することで、`/`でアクセスできるようになる
- [`_app.tsx`](https://nextjs.org/docs/pages/building-your-application/routing/custom-app)を`page`ディレクトリ内にセットすることで、これが global layout となる
- [`_document.tsx`](https://nextjs.org/docs/pages/building-your-application/routing/custom-document)を`page`ディレクトリ内にセットすることで、最初のレスポンスとなる

### [`pages` Routing Conventions](https://nextjs.org/docs/getting-started/project-structure#pages-routing-conventions)

#### Special Files

- \_app
- \_document
- \_error
- 404
- 500

#### Routes

- index
- folder/index
