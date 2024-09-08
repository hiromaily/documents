# HTMX with Hono

## `src/index.ts`（バックエンド）

TypeScriptでHonoを使ってバックエンドを定義するファイル

```ts
import { Hono } from 'hono'
import { serveStatic } from 'hono/serve-static.module'

const app = new Hono()

// 静的ファイルを提供するミドルウェア
app.use('/static/*', serveStatic({ root: './public' }))

// ルートエンドポイント
app.get('/', (c) => {
  return c.text('Hello Hono!', 200)
})

// htmxで使うAPIエンドポイント
app.get('/fetch-data', (c) => {
  return c.html('<p>This is the content loaded via HTMX!</p>')
})

app.post('/submit-form', async (c) => {
  const data = await c.req.parseBody()
  const username = data['username']
  return c.html(`<p>Thank you, ${username}, for submitting the form!</p>`)
})

app.fire()
```

## `public/index.html`（フロントエンド）

htmxを使ったフロントエンドのHTMLファイルだ。静的ファイルとしてサーバーから提供される。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>HTMX and Hono Example</title>
    <script src="https://unpkg.com/htmx.org@1.4.2" defer></script>
</head>
<body>
    <h1>HTMX and Hono Example</h1>
    <button hx-get="/fetch-data" hx-target="#result">Load Data</button>
    <div id="result"></div>

    <form hx-post="/submit-form" hx-target="#form-status" hx-swap="outerHTML">
        <input type="text" name="username" placeholder="Enter your name"/>
        <button type="submit">Submit</button>
    </form>
    <div id="form-status"></div>
</body>
</html>
```
