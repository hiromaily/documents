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

```
Content-Security-Policy: upgrade-insecure-requests;
```

## Other HTTP Security Headers
### X-Content-Type-Options
このヘッダーを使用して、特定の種類の攻撃から保護するのに役立つ MIME タイプ スニッフィングを防止できる。 例えば：

```
X-Content-Type-Options: nosniff
```
このヘッダーは、応答の MIME タイプを盗聴しないようにブラウザに指示し、代わりに応答ヘッダーで指定されたコンテンツ タイプを使用する。

### X-Frame-Options (Deprecated)
このヘッダーは、クリックジャッキング攻撃を防ぐために使用できます。クリックジャッキング攻撃は、ユーザーをだまして非表示または偽装したリンクをクリックさせるために使用できる。 例えば：

```
X-Frame-Options: DENY
```
このヘッダーは、ページがフレームまたは iframe に読み込まれるのを防ぎ、クリックジャッキング攻撃から保護するのに役立つ。

#### Replacement
Content security policyの`frame-ancestors` directiveを使う

### X-XSS-Protection　(Deprecated)
最新のブラウザではサポートされていない

このヘッダーを使用して、ブラウザーの組み込み XSS 保護を有効にすることができる。これは、クロスサイト スクリプティング攻撃から保護するのに役立つ。 例えば：
```
X-XSS-Protection: 1; mode=block
```
このヘッダーは、ブラウザーの組み込み XSS 保護を有効にし、XSS 攻撃が検出された場合にページをブロックするように指示する。
#### Replacement
Content security policyを使う