# 環境変数

## dotenv

### [dotenvx](https://dotenvx.com/)

- 暗号化したenvを使うことができる
- 公開鍵暗号をつかって暗号化する

暗号化が必要ない値は.envファイルに直接記載する。
暗号化が必要な値は以下のコマンドで追加･変更を行う。

```sh
# envの設定
dotenvx set {KEY] {value} -f .env.example

# 環境変数確認方法
# dotenvx get DATABASE_URL -f .env.local
dotenvx get {KEY] -f .env.example
```
