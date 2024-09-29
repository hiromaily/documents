# Actions secrets and variables

![github actions secret](../../../images/github-actions-secret.png "github actions secret")

## シークレット情報の追加

- `Repository secrets`の`New repository secret`から、名前と値を入力する

```yaml
- name: Deploy to AWS
    env:
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
```
