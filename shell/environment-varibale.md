# 環境変数

## 環境変数にアクセスするオーバーヘッド

一般的に非常に低い。実際のところ、環境変数はOSのレベルで管理されており、環境変数が通常メモリ上のシンプルなキー・バリュー形式で管理されているため、アクセスには大きなコストがかからない。
一般的なアプリケーションで環境変数にアクセスすることによるオーバーヘッドは極めて低く、一般的に無視できるレベルだが、特にシステムのパフォーマンスを気にするリアルタイム系アプリケーションや大量の環境変数を操作する特殊なケースでない限り、この点での心配はほとんど不要。

## 環境変数へのアクセスに伴う処理

1. **プロセスの環境ブロック参照**: プロセスが起動する際に、環境変数はそのプロセスの環境ブロックに含まれる。アクセスする際は、この環境ブロックを参照するだけなので非常に高速。

2. **キーの検索**: 環境ブロックはハッシュテーブルのような実装になっているため、キーの検索も効率的に行われる。

これらの操作はすべて、非常に短時間で完了する。別途アンチパターンや特殊なケースを除けば、`プログラムが多数の環境変数に頻繁にアクセスするような極端なシナリオでない限り`、パフォーマンスへの影響はほぼ無視してよいレベル。
これらの処理は、CPUサイクル程度の時間で完了するため、ほとんどの実行環境で無視できるほどのオーバーヘッドしか発生しない。

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

### dotenvxコマンド

```sh
> dotenvx --help
Usage: @dotenvx/dotenvx [options] [command] [command] [args...]

a better dotenv–from the creator of `dotenv`

Arguments:
  command                      dynamic command
  args                         dynamic command arguments

Options:
  -l, --log-level <level>      set log level (default: "info")
  -q, --quiet                  sets log level to error
  -v, --verbose                sets log level to verbose
  -d, --debug                  sets log level to debug
  -V, --version                output the version number
  -h, --help                   display help for command

Commands:
  run [options]                inject env at runtime [dotenvx run -- yourcommand]
  get [options] [key]          return a single environment variable
  set [options] <KEY> <value>  set a single environment variable
  encrypt [options]            convert .env file(s) to encrypted .env file(s)
  decrypt [options]            convert encrypted .env file(s) to plain .env file(s)
  ext [command] [args...]      🔌 extensions
  pro                          🏆 pro
```

```sh
# envの設定
dotenvx set {KEY] {value} -f .env.example

# 環境変数確認方法
# dotenvx get DATABASE_URL -f .env.local
dotenvx get {KEY] -f .env.example

# 環境変数をruntimeに展開
dotenvx run -f .env.local -- go run ./cmd/app1/
```
