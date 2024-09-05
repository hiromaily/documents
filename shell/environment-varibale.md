# 環境変数

## dotenv

### [dotenvx](https://dotenvx.com/)

- 暗号化したenvを使うことができる
- 公開鍵暗号をつかって暗号化する
  - 公開鍵で暗号化し、プライベート鍵で複合化する
- 暗号化が必要ない値は.envファイルに直接記載する。
- 暗号化が必要な値は以下のコマンドで追加･変更を行う。

```env
DOTENV_PUBLIC_KEY_LOCAL="036132482ea3f4e5e55ea944be15a93c740b32ea7300c5d503428fe14511ec7189"
DATABASE_URL="encrypted:BP8JW7odG1AiZ2rgj3Six3yjvtXWbGUBCIbwm0sSdnUSZLo1shy9ptFY82EGxip9R9MrP2L7uSyreqU0P2BJqB0KAu16d74l48f8h+VwzCdeCjYmenuloSHfLuyYONH1er9AUt6Eva+WaUPsD9Sgkqp+gpYD0Shve+vzlNZvOqs2PekGtpkhcvKN0fpO+yVYncrm7PJg0Q=="
```

```sh
# envの設定
dotenvx set {KEY] {value} -f .env.example

# 環境変数確認方法
# dotenvx get DATABASE_URL -f .env.local
dotenvx get {KEY] -f .env.example
```
