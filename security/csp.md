# Content-Security-Policy

コンテンツ セキュリティ ポリシーを設定し、Web アプリケーションのセキュリティを向上させるために使用できる HTTP セキュリティ レスポンス ヘッダーは他にも多数るが、軽減しようとしている特定のセキュリティ リスクを慎重に検討し、それらのリスクに対処するための適切なヘッダーを選択することが重要
Cross-site Scripting (XSS) や Clickjacking を防ぐのに有効

## Content-Security-Policy
このヘッダーを使用して、Web アプリケーションのコンテンツ セキュリティ ポリシー (CSP) を設定できる。 たとえば、次のように、信頼できるドメインからのリソースのロードのみを許可するポリシーを設定できる。


以下のポリシーは、現在のドメインと信頼できるドメイン https://trusted-domain.com からのリソースのロードのみを許可する。
```
Content-Security-Policy: default-src 'self' https://trusted-domain.com;
```

## [8 Best Content Security Policies for 2022](https://www.reflectiz.com/blog/8-best-content-security-policies/)
### 1. Basic CSP Policy
- この基本的なポリシーは、default ディレクティブで使用されるリソースを元のドメインからのリソースに制限し、インライン スクリプト/スタイルの実行を防ぐ
- これが、このポリシーに`cross-site framing` と `cross-site form submission`が含まれている方法となる。
- つまり、これらの制限により、サイトの攻撃対象領域が減少し、サイトがより安全になる。
- このポリシーは、ほとんどの最新のブラウザーに適用できる。

- 基本的なポリシーは、次のことを前提としている
  - 外部ウェブサイトへのフォーム送信はない
  - ウェブサイトを構成するために他のウェブサイトは必要ない(frameは使わない)
  - ドキュメントと同じドメインがすべてのリソースをホストする
    - これは難しいかもしれない
  - スクリプトとスタイル リソースの`inlines`または`evals`はない

```
Content-Security-Policy: default-src ‘self’; frame-ancestors ‘self’; form-action ‘self’;
 Or
Content-Security-Policy: default-src ‘none’; script-src ‘self’; connect-src ‘self’; img-src ‘self’; style-src ‘self’; frame-ancestors ‘self’; form-action ‘self’;
```

### 2. Basic CSP Policy – upgrade-insecure-requests
- このディレクティブは、HTTP から HTTPS に移行する開発者向け
- これにより、HTTP 経由で提供されるサイトのすべての安全でない URL が、安全な URL (HTTPS 経由で提供される) に置き換えられたかのように扱われる
- このポリシーは、セキュリティで保護された URL に変換する必要がある、安全でない従来の URL が多数ある Web サイト向けに設計されている

```
Content-Security-Policy: upgrade-insecure-requests;
```

### 3. Basic CSP Policy to Prevent Framing Attacks
- クリックジャッキングやクロスサイト リークなどのフレーミング攻撃は、サイトの脆弱性を利用して、サードパーティの部外者のコンテンツに侵入することに依存してる。たとえば、クリックジャッキングは悪意のあるコードを隠し、ユーザーをだまして別の要素を装った要素をクリックさせる。これらの攻撃を防ぐために CSP ポリシーを実装するには、次のディレクティブを使用する

- コンテンツのすべてのフレーミングを禁止するには:
```
Content-Security-Policy: frame-ancestors 'none';
```
- サイト自体のフレーミングを許可するには:
```
Content-Security-Policy: frame-ancestors’ self’;
```
- 信頼できるドメインからのフレーミングを許可するには:
```
Content-Security-Policy: frame-ancestors trusted.com;
```

### 4. Strict Policy
- 厳格なコンテンツ セキュリティ ポリシーはナンスまたはハッシュに基づいている。 厳密な CSP を使用することで、ハッカーが HTML インジェクションの欠陥を使用してブラウザに悪意のあるスクリプトを強制的に実行させることを防ぐ。 このポリシーは、従来の`stored`、`reflected`、およびさまざまな DOM XSS 攻撃に対して特に効果的。
- これらのXSS 攻撃にはわずかな違いがある。 
  - DOM ベースの XSS は、DOM 内の潜在的に危険なシンクにデータを書き込むことによって、信頼できないソースから発生したデータを処理する。 
  - reflected XSS は、サイトまたはアプリケーションが HTTP 要求でデータを受信したときに発生する。これには、安全でない方法で即時応答内のデータが含まれる。
  - stored XSS は、通常ユーザー入力が格納されるサーバーにコードを挿入する。 このタイプの攻撃は、メッセージ ボードなどのユーザー データを保存するサイトに対してのみ平準化できる。 厳格なコンテンツ セキュリティ ポリシーにより、これらすべての攻撃を防ぐことができる。

- 厳格なポリシーは、次の 2 つのレベルで適用できます。

```
# Moderate Strict Policy:
script-src ‘nonce-r4nd0m’ ‘strict-dynamic’;
object-src ‘none’; base-uri ‘none’;
```
```
# Locked Down Strict Policy:
script-src ‘nonce-r4nd0m’;
object-src ‘none’; base-uri ‘none’;
```

### 5: Refactoring Inline Code
- デフォルトの `default-src` または `script-src` ディレクティブがアクティブな場合、セキュリティ ポリシーは、HTML にインラインで配置された JavaScript コードをデフォルトで無効にする
```js
// default-src/script-src によって無効化されたコード
<script>
var num = "20"
<script>
```
そのため、以下のように変更する必要がある
```js
<script src="app.js">
</script>
```
- インライン コードの制限はインライン イベント ハンドラーにも適用されるため、次の構成が CSP でブロックされる
```html
<button id="button1" onclick="doSomething()">
```
そのため、以下のように変更する必要がある
```js
document.getElementById("button1").addEventListener('click', doSomething);
```

### 6: CSP with Fetch Directives
- Fetchディレクティブは、特定のリソースをロードできる場所を制御し、信頼するソースをブラウザに伝える。 CSP に関して言えば、Fetchディレクティブを使用すると、リソースをロードできる場所を制御できるため、外部の悪意のあるリソースがサイトに侵入するのを防ぐことができる。
- `script-src` などのディレクティブを使用すると、開発者はスクリプトの信頼できるソースをページ上で実行できるようになる。
- `font-src` は Web フォントのソースを記述し、
- `child-src` を使用すると、開発者はネストされたブラウジング コンテキストとワーカー実行コンテキストを制御できる。
- さらに、ディレクティブにより、開発者はサイトにアクセスできるコンテンツのソースを制限できるため、攻撃者が悪意のあるコードを追加するのを防ぐことができる。
- ディレクティブは常に必要であるため、CSP ヘッダーにディレクティブが追加されていない場合、システムは自動的に `default-src` にフォールバックします。

### 7: CSP with Document Directives
- Documentディレクティブは、コンテンツ セキュリティ ポリシーが適用されるドキュメントのプロパティをブラウザに通知する。 たとえば、ドキュメントの要素として使用できる URL を次のように制限する。

```
Content-Security-Policy: base-uri <source>;
Content-Security-Policy: base-uri <source> <source>;
```
または、要求されたリソースのサンドボックスを有効にすることによって:
```
Content-Security-Policy: sandbox;
Content-Security-Policy: sandbox <value>;
```

### 8: CSP with Navigation Directives
- Navigatingディレクティブは、ドキュメントがフォームをナビゲートまたは送信できる URL を制限する。
- 次に、ナビゲーション ディレクティブ ポリシーは、ユーザーがフォームを移動または送信できる場所を制御する。
- ナビゲーション ディレクティブは `default-src` ディレクティブに戻らず、代わりに次のようなディレクティブを含めます。
```
# フォームを送信できる URL を制限する
Content-Security-Policy: form-action <source>;
Content-Security-Policy: form-action <source> <source>;

# ドキュメントがナビゲーションを開始できる URL:
Content-Security-Policy: navigate-to <source>;
Content-Security-Policy: navigate-to <source> <source>;
```

