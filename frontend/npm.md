# npm

## private リポジトリを使っているときに遭遇した npm エラー例

```sh
npm ERR! An unknown git error occurred
npm ERR! command git --no-replace-objects ls-remote ssh://git@github.com/org/repo.git
npm ERR! remote: Support for password authentication was removed on August 13, 2021.
npm ERR! remote: Please see https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls for information on currently recommended modes of authentication.
npm ERR! fatal: Authentication failed for 'https://github.com/org/repo.git/'
```

## [About remote repositories](https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls)

### HTTPS URL を使ったクローン作成

- `https://` clone URL は、可視性に関係なく、すべてのリポジトリで利用可能で、ファイアウォールやプロキシの背後にいる場合でも機能する
- コマンドラインで HTTPS URL を使ってリモートリポジトリに`git clone`,`git fetch`,`git pull`,`git push`するとき、Git は GitHub のユーザー名とパスワードを尋ねてくる。
- Git がパスワードの入力を求めたら、個人用のアクセストークンを入力するか、[Git Credential Manager](https://github.com/GitCredentialManager/git-credential-manager/blob/main/README.md) のようなクレデンシャル・ヘルパーを使うこともできる。
- Git のパスワードベースの認証は、より安全な認証方法を採用するために削除された。詳細は、[Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

### [Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

- パスワードの代わりに使用するパーソナルアクセストークンを、コマンドラインまたは API で作成することができる
- ただし、アクセストークンはパスワードのように使う必要がある
  - コマンドラインから GitHub にアクセスするには、パーソナルアクセストークンを作成する代わりに GitHub CLI や Git Credential Manager を使うことを検討する
  - パーソナルアクセストークンをスクリプトで使用する場合は、トークンをシークレットとして保存して GitHub Actions でスクリプトを実行することを検討する。詳細は[Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)

#### パーソナルアクセストークンについて

- パーソナルアクセストークンは、GitHubAPI や コマンドラインを使用する際に、GitHub への認証にパスワードを使用する代わりに使用するもの
- パーソナルアクセストークンは、自分自身のために GitHub のリソースにアクセスするためのもの
- 組織を代表してリソースにアクセスする場合や、長期間の統合を行う場合は、GitHub App を使用する必要がある。詳細は、[About apps](https://docs.github.com/en/developers/apps/getting-started-with-apps/about-apps)にて
- GitHub は現在、2 種類の個人アクセストークンをサポートしている
  - fine-grained パーソナルアクセストークン
  - パーソナルアクセストークン (クラシック)
- GitHub では、可能な限りパーソナルアクセストークン (クラシック) ではなく、fine-grained パーソナルアクセストークンを使用することを推奨している
- fine-grained パーソナルアクセストークンは、個人アクセストークン (クラシック) に比べてセキュリティ面でいくつかの利点がある

- 各トークンは、1 人のユーザーまたは組織が所有するリソースにのみアクセスできる
- 各トークンは特定のリポジトリにのみアクセスすることができる
- 各トークンには特定のパーミッションが付与され、パーソナルアクセストークン（クラシック）に付与されるスコープよりも高い制御が可能
- 各トークンには有効期限を設定する必要がある
- 組織のオーナーは、組織内のリソースにアクセスできる fine-grained パーソナルアクセストークンに対して承認を求めることができる

- Note: 一部の機能は personal access tokens (classic)のみで機能する

### [Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)

- Encrypted secrets は、組織、リポジトリ、リポジトリ環境での機密情報の保管を可能にする
- Github Actions のワークフローで使うことができる
- [libsodium sealed box](https://libsodium.gitbook.io/doc/public-key_cryptography/sealed_boxes)を使用して、シークレットが GitHub に届く前に暗号化され、ワークフローで使用するまで暗号化されたままであることを保証する
- 組織レベルで保存されたシークレットの場合、アクセスポリシーを使用して、どのリポジトリが組織のシークレットを使用できるかを制御できる
- 組織レベルのシークレットでは、複数のリポジトリ間でシークレットを共有できるため、シークレットを重複して作成する必要性が低くなる
- 組織シークレットを 1 か所で更新すると、そのシークレットを使用するすべてのリポジトリワークフローで変更が有効になることも保証される
- 環境レベルに保存されたシークレットの場合、必要なレビューアがシークレットへのアクセスを制御できるようにすることができる
- ワークフロージョブは、必要な承認者によって承認されるまで、環境シークレットにアクセスすることができない

## Private リポジトリの npm での Install

- GitHub トークン(パーソナルアクセストークン)、つまり x-oauth-basic でのベーシック認証を使った GitHub プライベートリポジトリの読み込み

```json
 "dependencies": {
    "package-name": "git+https://<github_token>:x-oauth-basic@github.com/<user>/<repo>.git"
  }
```

- ここで利用する GitHub トークンには`repo権限`が必要

### In Github Action

```yml
- run: git config --global url."https://${{ secrets.GIT_TOKEN }}:x-oauth-basic@github.com".insteadOf "https://github.com"
```

- [問題が発生するケース: Private repo w/tag in workflow](https://github.com/actions/runner/issues/1718)

### その他リファレンス

- [GitHub Actions で private リポジトリを yarn で依存解決する](https://zenn.dev/mallowlabs/articles/yarn-private-repo-on-github-actions)
- [npm の private registry から GitHub Packages Registry に移行する](https://tech.plaid.co.jp/npm-private-registry-to-github-packages-registry)

## npm private registry

- [Creating and publishing private packages](https://docs.npmjs.com/creating-and-publishing-private-packages)
- 後述の Github Package Registry を使った方がよい
- GitHub が npm を買収するため、将来的に npm private registry は GitHub Packages Registry へと統合される予定

### Reference

- [private-npm-in-gh-actions.md](https://gist.github.com/nandorojo/46b3e46de12177b9ad7e4d454310de21)

## Github Packages でプライベート npm パッケージを公開する

- [Reference](https://www.memory-lovers.blog/entry/2022/10/13/173000)
- [Github Packages](https://github.co.jp/features/packages)
  - Github Package Registry と言われるもの
- [Github npm レジストリの利用](https://docs.github.com/ja/packages/working-with-a-github-packages-registry/working-with-the-npm-registry)
- GitHub Packages を使えば、非公開パッケージを用意できる
- 従量課金製だが、free プランもある

### パッケージを公開する方法

1. package.json の設定
2. Github Action で自動で package をリリースするように設定

### パッケージを利用する方法

1. アクセストークンを取得
2. `.npmrc`を用意する
