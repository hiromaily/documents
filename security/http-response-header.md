# HTTP Response Header for Security





## X-Content-Type-Options
このヘッダーを使用して、特定の種類の攻撃から保護するのに役立つ MIME タイプ スニッフィングを防止できる。 例えば：

```
X-Content-Type-Options: nosniff
```
このヘッダーは、応答の MIME タイプを盗聴しないようにブラウザに指示し、代わりに応答ヘッダーで指定されたコンテンツ タイプを使用する。

## X-Frame-Options (Deprecated)
このヘッダーは、クリックジャッキング攻撃を防ぐために使用できます。クリックジャッキング攻撃は、ユーザーをだまして非表示または偽装したリンクをクリックさせるために使用できる。 例えば：

```
X-Frame-Options: DENY
```
このヘッダーは、ページがフレームまたは iframe に読み込まれるのを防ぎ、クリックジャッキング攻撃から保護するのに役立つ。

#### Replacement
Content security policyの`frame-ancestors` directiveを使う

## X-XSS-Protection　(Deprecated)
最新のブラウザではサポートされていない

このヘッダーを使用して、ブラウザーの組み込み XSS 保護を有効にすることができる。これは、クロスサイト スクリプティング攻撃から保護するのに役立つ。 例えば：
```
X-XSS-Protection: 1; mode=block
```
このヘッダーは、ブラウザーの組み込み XSS 保護を有効にし、XSS 攻撃が検出された場合にページをブロックするように指示する。
#### Replacement
Content security policyを使う