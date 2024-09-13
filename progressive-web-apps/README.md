# Progressive Web Apps (PWA)

PWA とは、`Progressive Web Apps`の略で、Web 技術を使って、ネイティブアプリのようなエクスペリエンスを提供するウェブアプリケーションのことで、モバイル向けの Web サイトをアプリのように使える仕組みのこと。PWA は Web とモバイルアプリの利点を組み合わせたものと言える。

## 主な特徴

1. **プログレッシブ**:
   - あらゆるユーザーに対して、ブラウザの機能がフルに対応していなくても動作する。これは「プログレッシブエンハンスメント」技術によって可能になる。
2. **レスポンシブ**:

   - モバイル、タブレット、デスクトップなど、あらゆるデバイスに適応する。

3. **オフライン機能**:

   - Service Worker を使用することで、ネットワークの状態に関係なく動作する。ネットワークがオフラインのときでもコンテンツの一部をキャッシュから提供できる。

4. **アプリ感覚**:

   - ネイティブアプリのようなインタラクションとナビゲーションを提供する。

5. **インストール可能**:

   - ユーザーは PWA をホーム画面に追加し、ネイティブアプリのように利用できる。

6. **安全性**:

   - HTTPS を通して提供されるため、セキュリティが確保されている。

7. **プッシュ通知**:
   - ユーザーにリアルタイムで通知を送ることができる。

### 特徴(個別にまとめたもの)

- 通常の Web ページとネイティブアプリそれぞれの良い部分を合わせもっており、Web ページのように大きなリーチを得ることが出来ながら、プッシュ通知やホーム画面へのアイコン追加などネイティブアプリのような機能を搭載することが出来る

- プログレッシブ:
  - すべてのブラウザで動作し、徐々に機能を向上させることができる。これは、古いブラウザでも基本的な機能は利用でき、新しいブラウザではより高度な機能が利用可能
- オフライン動作:
  - PWA は、一度ウェブページにアクセスしてキャッシュを保存した後でも、オフライン状態で使用できることがある
- インストール不要:
  - ユーザーはアプリをダウンロードしてインストールする必要はない。ウェブブラウザを通じてアクセスし、ホーム画面にアイコンを追加するのみ
- 通知:
  - PWA はユーザーに対してプッシュ通知を送信することができる
- セキュリティ
  - HTTPS を使用してアクセスするため、セキュリティが強化されている

## PWA を作るための基本技術

1. **HTML, CSS, JavaScript**:

   - PWA は主にこれらの標準ウェブ技術を使って作られる。

2. **Service Workers**:

   - JavaScript ファイルで、背景で動作し、オフライン機能、プッシュ通知、リソースのキャッシュなどを管理する。

3. **Web App Manifest**:
   - アプリの名前、アイコン、テーマカラー、起動 URL など、PWA のメタ情報を含む JSON ファイル。このファイルがブラウザに対し、PWA として認識される要件を満たす。

## 実装の基本手順

1. **Service Worker の登録**:

   ```javascript
   if ("serviceWorker" in navigator) {
     navigator.serviceWorker
       .register("/service-worker.js")
       .then(function (registration) {
         console.log(
           "Service Worker registered with scope:",
           registration.scope
         );
       })
       .catch(function (error) {
         console.log("Service Worker registration failed:", error);
       });
   }
   ```

2. **Web App Manifest の作成**:

   ```json
   {
     "name": "My App",
     "short_name": "App",
     "start_url": "/",
     "display": "standalone",
     "background_color": "#FFFFFF",
     "description": "My awesome app",
     "icons": [
       {
         "src": "icon/lowres.webp",
         "sizes": "48x48",
         "type": "image/webp"
       },
       {
         "src": "icon/hd_highres.png",
         "sizes": "256x256",
         "type": "image/png"
       }
     ]
   }
   ```

3. **HTTPS 導入**:
   - PWA を安全に提供するために、HTTPS 経由でサーバーを設定する。

## PWA のテストやデプロイ

- **Lighthouse**:

  - Google Chrome の開発者ツールに内蔵されている Lighthouse を使うと、PWA の品質を自動的にテストできる。

- **デプロイ**:
  - PWA は静的ファイルとして提供されることが多い。Netlify、Vercel、Firebase などのホスティングサービスを利用することが一般的。

## References

- [web.dev: pwa](https://web.dev/progressive-web-apps/)
- [Getting started with Progressive Web Apps](https://developer.chrome.com/blog/getting-started-pwa/)
