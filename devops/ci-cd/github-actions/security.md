# Security

## Actions secrets and variables

![github actions secret](https://github.com/hiromaily/documents/raw/main/images/github-actions-secret.png "github actions secret")

### シークレット情報の追加

- `Repository secrets`の`New repository secret`から、名前と値を入力する

```yaml
- name: Deploy to AWS
    env:
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
```

## アクセスキーを使ってAWSへアクセスするのは非推奨

- [アクセスキーを使ってGitHub ActionsからAWSへアクセスするのはもうやめよう!](https://qiita.com/sigma_devsecops/items/3e2fb50770def1c3a098)
  - Open ID Connectの技術を利用する
